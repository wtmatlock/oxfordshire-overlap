
import community as community_louvain
from collections import Counter
import networkx as nx
import numpy as np
import pandas as pd


def elist_to_graph(df):
    """Converts MASH edgelist to graph object"""
    df.columns = ['sequence1', 'sequence2', 'mashdist', 'pvalue', 'hashmatch']
    df['sim'] = df['hashmatch']
    df['sim'] = [eval(str(x)) for x in df['sim']]
    G = nx.from_pandas_edgelist(df, 'sequence1', 'sequence2', edge_attr='sim')
    return G


def louvain_benchmark(G, points):
    """For each threshold, calculates the number of communities and the community coverage"""
    output = pd.DataFrame(columns=['trial', 'threshold', 'num_comm', 'perc_in_comm'])
    for n in range(0, 10):
        for i in points:
            G.remove_edges_from([(u, v, d) for (u, v, d) in G.edges(data=True) if d['sim'] < i])
            partition = community_louvain.best_partition(G, weight='sim')
            members = [v for v in partition.values()]  # list of community members
            counts = Counter(members)
            del counts[0]  # drop unassigned nodes
            comm_size = [counts[i] for i in counts if counts[i] >= 3]
            m = len(comm_size)  # number of communities larger than 3 nodes
            p = 100 * (sum(comm_size) / len(members))  # percentage in communities
            output = output.append(pd.DataFrame([[n, i, m, p]], columns=output.columns))
        G = nx.from_pandas_edgelist(data, 'sequence1', 'sequence2', edge_attr='sim')
        print(n)
    return output


data = pd.read_csv('/Users/willmatlock/Desktop/overlap_network/edgelist.tsv', sep='\t', header=None) # import MASH edgelist output

graph = elist_to_graph(data)

p = [round(i, 3) for i in np.linspace(0, 1, 41)]
df = louvain_benchmark(graph, p)
df.to_csv('/Users/willmatlock/Desktop/overlap_network/louvain_benchmark.csv') # output df
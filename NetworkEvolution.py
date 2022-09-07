import numpy as np
import networkx as nx
import pandas as pd


def elist_to_graph(df):
    """Converts MASH edgelist to graph object"""
    df.columns = ['sequence1', 'sequence2', 'mashdist', 'pvalue', 'hashmatch']
    df['sim'] = df['hashmatch']
    df['sim'] = [eval(str(x)) for x in df['sim']]
    G = nx.from_pandas_edgelist(df, 'sequence1', 'sequence2', edge_attr='sim')
    return G


def lcc(G, points):
    """For each threshold, calculates the size of the largest connected component"""
    lcc = []
    for i in list(points):
        G.remove_edges_from([(u, v, d) for (u, v, d) in G.edges(data=True) if d['sim'] < i])
        lcc.append(len(max(nx.connected_components(G), key=len)))
        print(lcc)
        print(i)
    return lcc


def ncc(G, points):
    """For each threshold, calculates the number of connected components"""
    ncc = []
    for i in list(points):
        G.remove_edges_from([(u, v, d) for (u, v, d) in G.edges(data=True) if d['sim'] < i])
        ncc.append(nx.number_connected_components(G))
        print(ncc)
        print(i)
    return ncc

def singletons(G, points):
    """For each threshold, calculates the number of connected components"""
    sin = []
    for i in list(points):
        G.remove_edges_from([(u, v, d) for (u, v, d) in G.edges(data=True) if d['sim'] < i])
        sin.append(len(list(nx.isolates(G))))
        print(sin)
        print(i)
    return sin


data = pd.read_csv('/Users/willmatlock/Desktop/overlap_network/plasmid_edgelist_jaccard.tsv', sep='\t') # import MASH edgelist output
graph = elist_to_graph(data)
p = np.linspace(0, 1, 1000)
largest_cc = lcc(graph, p)

data = pd.read_csv('/Users/willmatlock/Desktop/overlap_network/plasmid_edgelist_jaccard.tsv', sep='\t') # import MASH edgelist output
graph = elist_to_graph(data)
p = np.linspace(0, 1, 1000)
num_cc = ncc(graph, p)

data = pd.read_csv('/Users/willmatlock/Desktop/overlap_network/plasmid_edgelist_jaccard.tsv', sep='\t') # import MASH edgelist output
graph = elist_to_graph(data)
p = np.linspace(0, 1, 1000)
num_sin = singletons(graph, p)

pd.DataFrame({"Threshold": p,
              "Largest Connected Component": largest_cc,
              "Number of Connected Components": num_cc,
              "Number of Singletons": num_sin}).to_csv('/Users/willmatlock/Desktop/overlap_network/lcc_ncc_output.csv') # output df

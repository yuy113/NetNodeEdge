% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/edge_score.R
\name{uniform.beta.node.edge.score}
\alias{uniform.beta.node.edge.score}
\title{Generate node scores,edge scores and network}
\usage{
uniform.beta.node.edge.score(pval.node, pval.edge, FDR.node, FDR.edge, dat)
}
\arguments{
\item{pval.node}{P values from multiple hypothesis testing in vector format
hypothesis testing on clinical outcome with each individual node (variable)
The names of the edges (names of two connecting nodes(variables)) must be specified.}

\item{pval.edge}{P values from multiple hypothesis testing in vector format
The names of the edges (names of two connecting nodes(variables)) must be specified.}

\item{FDR.node}{The overall level of False Discovery Rate level for multiple testing
on all the nodes(variables) ,typically 0.05,0.01}

\item{FDR.edge}{The level of False Discovery Rate level for multiple testing
on all possible edges,typically 0.01,0.001}

\item{dat}{Dataset containing the observations for p covariates (nodes)
The column names of the dat must be specified.}
}
\value{
A list of five elements as decribed below:

This function returns an object with class \emph{NetworkScore}. The items in the object are:
\item{NodeScore}{The vector of scores of the nodes in network}
\item{EdgeScore}{The vector of scores of all possible edges in network}
\item{FDR.node}{False Discovery Rate for multiple testing on the nodes in the network}
\item{FDR.edge}{False Discovery Rate for multiple testing on all possible edges in the network}
\item{Network}{An igraph object-Network with attributes in nodes-node score and name,and edges-edge scores and names}
}
\description{
Generate both node and edge scores for biological correlation network
based on P values of clinical outcome and nodes
and also P values by multiple permulation tests
on all the possible edges in biological correlaton network
This function calculates edge scores based on P values in multiple testing
assuming P values follows a mixture of two beta distributions-
 beta(a,1),beta(1,1)-Uniform(0,1)
with those in permutated samples through nonparametric permutation tests.
Also this function calculates node scores based on P values in multiple testing
assuming P values follows a mixture of two beta distributions-
 beta(a,1),beta(1,1)-Uniform(0,1)
}
\examples{
dat1<-matrix(rnorm(4000),ncol=40,nrow=100)
colnames(dat1)<-paste("Var", as.character(1:40),sep="")

# simulate the p values for all the possible edges in the network
ind.pos.pval.edge<-rbinom(40*39/2,1,0.5)
pval.edge<-(1-ind.pos.pval.edge)*runif(40*39/2)+ind.pos.pval.edge*rbeta(40*39/2,0.1,1)
names(pval.edge)<-unlist(sapply(1:39,function(i){sapply((i+1):40, function(j){paste(paste("Var",
as.character(i),sep=""),paste("Var",as.character(j),sep=""),sep="_")})}))

# simulate p values for all the nodes in the network
ind.pos.pval.node<-rbinom(40,1,0.2)
pval.node<-(1-ind.pos.pval.node)*runif(40)+ind.pos.pval.node*rbeta(40,0.1,1)
names(pval.node)<-paste("Var", as.character(1:40),sep="")

# generate the node score-NodeScore, edge scores-EdgeScore and igraph object-Network
network.test<-uniform.beta.node.edge.score(pval.node,pval.edge,0.05,0.05,dat1)
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_edge_bend.R
\name{geom_edge_bend}
\alias{geom_edge_bend}
\alias{geom_edge_bend2}
\alias{geom_edge_bend0}
\title{Draw edges as diagonals}
\usage{
geom_edge_bend(
  mapping = NULL,
  data = get_edges(),
  position = "identity",
  arrow = NULL,
  strength = 1,
  flipped = FALSE,
  n = 100,
  lineend = "butt",
  linejoin = "round",
  linemitre = 1,
  label_colour = "black",
  label_alpha = 1,
  label_parse = FALSE,
  check_overlap = FALSE,
  angle_calc = "rot",
  force_flip = TRUE,
  label_dodge = NULL,
  label_push = NULL,
  show.legend = NA,
  ...
)

geom_edge_bend2(
  mapping = NULL,
  data = get_edges("long"),
  position = "identity",
  arrow = NULL,
  strength = 1,
  flipped = FALSE,
  n = 100,
  lineend = "butt",
  linejoin = "round",
  linemitre = 1,
  label_colour = "black",
  label_alpha = 1,
  label_parse = FALSE,
  check_overlap = FALSE,
  angle_calc = "rot",
  force_flip = TRUE,
  label_dodge = NULL,
  label_push = NULL,
  show.legend = NA,
  ...
)

geom_edge_bend0(
  mapping = NULL,
  data = get_edges(),
  position = "identity",
  arrow = NULL,
  strength = 1,
  flipped = FALSE,
  lineend = "butt",
  show.legend = NA,
  ...
)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link[ggplot2:aes]{ggplot2::aes()}}
or \code{\link[ggplot2:aes_]{ggplot2::aes_()}}. By default x, y, xend, yend, group and
circular are mapped to x, y, xend, yend, edge.id and circular in the edge
data.}

\item{data}{The return of a call to \code{get_edges()} or a data.frame
giving edges in correct format (see details for for guidance on the format).
See \code{\link[=get_edges]{get_edges()}} for more details on edge extraction.}

\item{position}{Position adjustment, either as a string naming the adjustment
(e.g. \code{"jitter"} to use \code{position_jitter}), or the result of a call to a
position adjustment function. Use the latter if you need to change the
settings of the adjustment.}

\item{arrow}{Arrow specification, as created by \code{\link[grid:arrow]{grid::arrow()}}.}

\item{strength}{The strength of the curvature of the bend. \code{0} will
result in a straight line while \code{1} will give a strong arc.}

\item{flipped}{Logical, Has the layout been flipped by reassigning the
mapping of x, y etc?}

\item{n}{The number of points to create along the path.}

\item{lineend}{Line end style (round, butt, square).}

\item{linejoin}{Line join style (round, mitre, bevel).}

\item{linemitre}{Line mitre limit (number greater than 1).}

\item{label_colour}{The colour of the edge label. If \code{NA} it will use
the colour of the edge.}

\item{label_alpha}{The opacity of the edge label. If \code{NA} it will use
the opacity of the edge.}

\item{label_parse}{If \code{TRUE}, the labels will be parsed into expressions
and displayed as described in \code{\link[grDevices:plotmath]{grDevices::plotmath()}}.}

\item{check_overlap}{If \code{TRUE}, text that overlaps previous text in the
same layer will not be plotted. \code{check_overlap} happens at draw time and in
the order of the data. Therefore data should be arranged by the label
column before calling \code{geom_text()}. Note that this argument is not
supported by \code{geom_label()}.}

\item{angle_calc}{Either 'none', 'along', or 'across'. If 'none' the label will
use the angle aesthetic of the geom. If 'along' The label will be written
along the edge direction. If 'across' the label will be written across the
edge direction.}

\item{force_flip}{Logical. If \code{angle_calc} is either 'along' or 'across'
should the label be flipped if it is on it's head. Default to \code{TRUE}.}

\item{label_dodge}{A \code{\link[grid:unit]{grid::unit()}} giving a fixed vertical shift
to add to the label in case of \code{angle_calc} is either 'along' or 'across'}

\item{label_push}{A \code{\link[grid:unit]{grid::unit()}} giving a fixed horizontal shift
to add to the label in case of \code{angle_calc} is either 'along' or 'across'}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{...}{Other arguments passed on to \code{\link[ggplot2:layer]{layer()}}. These are
often aesthetics, used to set an aesthetic to a fixed value, like
\code{colour = "red"} or \code{size = 3}. They may also be parameters
to the paired geom/stat.}
}
\description{
This geom draws edges as cubic bezier curves with the control points
positioned along the elbow edge. It has the appearance of a softened elbow
edge with the hard angle substituted by a tapered bend.
}
\section{Aesthetics}{

\code{geom_edge_bend} and \code{geom_edge_bend0} understand the following
aesthetics. Bold aesthetics are automatically set, but can be overridden.
\itemize{
\item \strong{x}
\item \strong{y}
\item \strong{xend}
\item \strong{yend}
\item \strong{circular}
\item edge_colour
\item edge_width
\item edge_linetype
\item edge_alpha
\item filter
}

\code{geom_edge_bend2} understand the following aesthetics. Bold aesthetics are
automatically set, but can be overridden.
\itemize{
\item \strong{x}
\item \strong{y}
\item \strong{group}
\item \strong{circular}
\item edge_colour
\item edge_width
\item edge_linetype
\item edge_alpha
\item filter
}

\code{geom_edge_bend} and \code{geom_edge_bend2} furthermore takes the following
aesthetics.
\itemize{
\item start_cap
\item end_cap
\item label
\item label_pos
\item label_size
\item angle
\item hjust
\item vjust
\item family
\item fontface
\item lineheight
}
}

\section{Computed variables}{


\describe{
\item{index}{The position along the path (not computed for the *0 version)}
}
}

\section{Edge variants}{

Many geom_edge_* layers comes in 3 flavors depending on the level of control
needed over the drawing. The default (no numeric postfix) generate a number
of points (\code{n}) along the edge and draws it as a path. Each point along
the line has a numeric value associated with it giving the position along the
path, and it is therefore possible to show the direction of the edge by
mapping to this e.g. \code{colour = after_stat(index)}. The version postfixed with a
"2" uses the "long" edge format (see \code{\link[=get_edges]{get_edges()}}) and makes it
possible to interpolate node parameter between the start and end node along
the edge. It is considerable less performant so should only be used if this
is needed. The version postfixed with a "0" draws the edge in the most
performant way, often directly using an appropriate grob from the grid
package, but does not allow for gradients along the edge.

Often it is beneficial to stop the drawing of the edge before it reaches the
node, for instance in cases where an arrow should be drawn and the arrowhead
shouldn't lay on top or below the node point. geom_edge_* and geom_edge_*2
supports this through the start_cap and end_cap aesthetics that takes a
\code{\link[=geometry]{geometry()}} specification and dynamically caps the termini of the
edges based on the given specifications. This means that if
\code{end_cap = circle(1, 'cm')} the edges will end at a distance of 1cm even
during resizing of the plot window.

All \verb{geom_edge_*} and \code{geom_edge_*2} have the ability to draw a
label along the edge. The reason this is not a separate geom is that in order
for the label to know the location of the edge it needs to know the edge type
etc. Labels are drawn by providing a label aesthetic. The label_pos can be
used to specify where along the edge it should be drawn by supplying a number
between 0 and 1. The label_size aesthetic can be used to control the size of
the label. Often it is needed to have the label written along the direction
of the edge, but since the actual angle is dependent on the plot dimensions
this cannot be calculated beforehand. Using the angle_calc argument allows
you to specify whether to use the supplied angle aesthetic or whether to draw
the label along or across the edge.
}

\section{Edge aesthetic name expansion}{

In order to avoid excessive typing edge aesthetic names are
automatically expanded. Because of this it is not necessary to write
\code{edge_colour} within the \code{aes()} call as \code{colour} will
automatically be renamed appropriately.
}

\examples{
require(tidygraph)
gr <- create_tree(20, 4) \%>\%
  mutate(class = sample(letters[1:3], n(), replace = TRUE)) \%>\%
  activate(edges) \%>\%
  mutate(class = sample(letters[1:3], n(), replace = TRUE))

ggraph(gr, 'tree') +
  geom_edge_bend(aes(alpha = after_stat(index)))

ggraph(gr, 'tree') +
  geom_edge_bend2(aes(colour = node.class))

ggraph(gr, 'tree') +
  geom_edge_bend0(aes(colour = class))
}
\seealso{
Other geom_edge_*: 
\code{\link{geom_edge_arc}()},
\code{\link{geom_edge_density}()},
\code{\link{geom_edge_diagonal}()},
\code{\link{geom_edge_elbow}()},
\code{\link{geom_edge_fan}()},
\code{\link{geom_edge_hive}()},
\code{\link{geom_edge_link}()},
\code{\link{geom_edge_loop}()},
\code{\link{geom_edge_parallel}()},
\code{\link{geom_edge_point}()},
\code{\link{geom_edge_span}()},
\code{\link{geom_edge_tile}()}
}
\author{
Thomas Lin Pedersen
}
\concept{geom_edge_*}

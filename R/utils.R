#' Get the angle of nodes and edges
#'
#' These helper functions makes it easy to calculate the angle associated with
#' nodes and edges. For nodes the angle is defined as the angle of the vector
#' pointing towards the node position, and is thus mainly suited for circular
#' layouts where it can be used to calculate the angle of labels. For edges it
#' is simply the angle of the vector describing the edge.
#'
#' @param x,y A vector of positions
#'
#' @param xend,yend The end position of the edge
#'
#' @param degrees Logical. Should the angle be returned in degree (`TRUE`)
#' or radians (`FALSE`). Defaults to `TRUE`.
#'
#' @return A vector with the angle of each node/edge
#'
#' @examples
#' require(tidygraph)
#' flareGraph <- tbl_graph(flare$vertices, flare$edges)
#'
#' ggraph(flareGraph, 'dendrogram', circular = TRUE) +
#'   geom_edge_diagonal0() +
#'   geom_node_text(aes(filter = leaf, angle = node_angle(x, y), label = shortName),
#'     hjust = 'outward', size = 2
#'   ) +
#'   expand_limits(x = c(-1.3, 1.3), y = c(-1.3, 1.3))
#' @export
#'
node_angle <- function(x, y, degrees = TRUE) {
  angles <- atan2(y, x)
  angles[angles < 0] <- angles[angles < 0] + 2 * pi
  if (degrees) {
    angles * 360 / (2 * pi)
  } else {
    angles
  }
}
#' @rdname node_angle
#'
#' @export
edge_angle <- function(x, y, xend, yend, degrees = TRUE) {
  x <- xend - x
  y <- yend - y
  node_angle(x, y, degrees)
}


### COPY FROM GGPLOT2 NON-EXPORTS
#' @importFrom scales rescale_mid
mid_rescaler <- function(mid) {
  function(x, to = c(0, 1), from = range(x, na.rm = TRUE)) {
    rescale_mid(x, to, from, mid)
  }
}
manual_scale <- function(aesthetic, values = NULL, breaks = waiver(), ..., limits = NULL) {
  # check for missing `values` parameter, in lieu of providing
  # a default to all the different scale_*_manual() functions
  if (is_missing(values)) {
    values <- NULL
  } else {
    force(values)
  }

  if (is.null(limits) && !is.null(names(values))) {
    # Limits as function to access `values` names later on (#4619)
    limits <- function(x) intersect(x, names(values))
  }

  # order values according to breaks
  if (is.vector(values) && is.null(names(values)) && !inherits(breaks, 'waiver') &&
      !is.null(breaks) && !is.function(breaks)) {
    if (length(breaks) <= length(values)) {
      names(values) <- breaks
    } else {
      names(values) <- breaks[1:length(values)]
    }
  }

  pal <- function(n) {
    if (n > length(values)) {
      cli::cli_abort("Insufficient values in manual scale. {n} needed but only {length(values)} provided.")
    }
    values
  }
  discrete_scale(aesthetic, "manual", pal, breaks = breaks, limits = limits, ...)
}
#' @importFrom scales zero_range
resolution <- function(x, zero = TRUE) {
  if (is.integer(x) || zero_range(range(x, na.rm = TRUE))) {
    return(1)
  }
  x <- unique0(as.numeric(x))
  if (zero) {
    x <- unique0(c(0, x))
  }
  min(diff(sort(x)))
}
#' @importFrom grid grobName
ggname <- function(prefix, grob) {
  grob$name <- grobName(grob, prefix)
  grob
}
element_render <- function(theme, element, ..., name = NULL) {
  el <- calc_element(element, theme)
  if (is.null(el)) {
    cli::cli_inform("Theme element {.var {element}} is missing")
    return(zeroGrob())
  }
  ggname(paste(element, name, sep = '.'), element_grob(el, ...))
}
.all_aesthetics <- c(
  'adj', 'alpha', 'angle', 'bg', 'cex', 'col', 'color', 'colour',
  'fg', 'fill', 'group', 'hjust', 'label', 'linetype', 'lower',
  'lty', 'lwd', 'max', 'middle', 'min', 'pch', 'radius', 'sample',
  'shape', 'size', 'srt', 'upper', 'vjust', 'weight', 'width',
  'x', 'xend', 'xmax', 'xmin', 'xintercept', 'y', 'yend', 'ymax',
  'ymin', 'yintercept', 'z'
)
.base_to_ggplot <- structure(
  c(
    'colour', 'colour', 'shape', 'size', 'linetype', 'size', 'angle', 'hjust',
    'fill', 'colour', 'ymin', 'ymax'
  ),
  .Names = c(
    'col', 'color', 'pch', 'cex', 'lty', 'lwd', 'srt', 'adj', 'bg',
    'fg', 'min', 'max'
  )
)
rename_aes <- function(x) {
  # Convert prefixes to full names
  full <- match(names(x), .all_aesthetics)
  names(x)[!is.na(full)] <- .all_aesthetics[full[!is.na(full)]]

  old_names <- match(names(x), names(.base_to_ggplot))
  names(x)[!is.na(old_names)] <- .base_to_ggplot[old_names[!is.na(old_names)]]

  x
}

translate_shape_string <- function(shape_string) {
  if (is.numeric(shape_string)) return(shape_string)
  # strings of length 0 or 1 are interpreted as symbols by grid
  if (nchar(shape_string[1]) <= 1) {
    return(shape_string)
  }

  pch_table <- c(
    "square open"           = 0,
    "circle open"           = 1,
    "triangle open"         = 2,
    "plus"                  = 3,
    "cross"                 = 4,
    "diamond open"          = 5,
    "triangle down open"    = 6,
    "square cross"          = 7,
    "asterisk"              = 8,
    "diamond plus"          = 9,
    "circle plus"           = 10,
    "star"                  = 11,
    "square plus"           = 12,
    "circle cross"          = 13,
    "square triangle"       = 14,
    "triangle square"       = 14,
    "square"                = 15,
    "circle small"          = 16,
    "triangle"              = 17,
    "diamond"               = 18,
    "circle"                = 19,
    "bullet"                = 20,
    "circle filled"         = 21,
    "square filled"         = 22,
    "diamond filled"        = 23,
    "triangle filled"       = 24,
    "triangle down filled"  = 25
  )

  shape_match <- charmatch(shape_string, names(pch_table))

  invalid_strings <- is.na(shape_match)
  nonunique_strings <- shape_match == 0

  if (any(invalid_strings)) {
    bad_string <- unique0(shape_string[invalid_strings])
    cli::cli_abort("Shape aesthetic contains invalid value{?s}: {.val {bad_string}}")
  }

  if (any(nonunique_strings)) {
    bad_string <- unique0(shape_string[nonunique_strings])
    cli::cli_abort(c(
      "shape names must be given unambiguously",
      "i" = "Fix {.val {bad_string}}"
    ))
  }

  unname(pch_table[shape_match])
}

#' @importFrom viridis scale_color_viridis
#' @export
viridis::scale_color_viridis

#' @importFrom viridis scale_fill_viridis
#' @export
viridis::scale_fill_viridis

# Wrapping vctrs data_frame constructor with no name repair
data_frame0 <- function(...) data_frame(..., .name_repair = "minimal")

# Wrapping unique0() to accept NULL
unique0 <- function(x, ...) if (is.null(x)) x else vec_unique(x, ...)

df_rows <- function(x, i) {
  cols <- lapply(x, `[`, i = i)
  data_frame0(!!!cols, .size = length(i))
}
split_matrix <- function(x, col_names = colnames(x)) {
  force(col_names)
  x <- lapply(seq_len(ncol(x)), function(i) x[, i])
  if (!is.null(col_names)) names(x) <- col_names
  x
}
# More performant modifyList without recursion
modify_list <- function(old, new) {
  for (i in names(new)) old[[i]] <- new[[i]]
  old
}
empty <- function(df) {
  is.null(df) || nrow(df) == 0 || ncol(df) == 0
}
split_indices <- function(group) {
  split(seq_along(group), group)
}
# Adapted from plyr:::id_vars
# Create a unique id for elements in a single vector
id_var <- function(x, drop = FALSE) {
  if (length(x) == 0) {
    id <- integer()
    n <- 0L
  } else if (!is.null(attr(x, 'n')) && !drop) {
    return(x)
  } else if (is.factor(x) && !drop) {
    x <- addNA(x, ifany = TRUE)
    id <- as.integer(x)
    n <- length(levels(x))
  } else {
    levels <- sort(unique0(x), na.last = TRUE)
    id <- match(x, levels)
    n <- max(id)
  }
  attr(id, 'n') <- n
  id
}
#' Create an unique integer id for each unique row in a data.frame
#'
#' Properties:
#' - `order(id)` is equivalent to `do.call(order, df)`
#' - rows containing the same data have the same value
#' - if `drop = FALSE` then room for all possibilites
#'
#' @param .variables list of variables
#' @param drop Should unused factor levels be dropped?
#'
#' @return An integer vector with attribute `n` giving the total number of
#' possible unique rows
#'
#' @keywords internal
#' @noRd
#'
id <- function(.variables, drop = FALSE) {
  nrows <- NULL
  if (is.data.frame(.variables)) {
    nrows <- nrow(.variables)
    .variables <- unclass(.variables)
  }
  lengths <- vapply(.variables, length, integer(1))
  .variables <- .variables[lengths != 0]
  if (length(.variables) == 0) {
    n <- nrows %||% 0L
    id <- seq_len(n)
    attr(id, 'n') <- n
    return(id)
  }
  if (length(.variables) == 1) {
    return(id_var(.variables[[1]], drop = drop))
  }
  ids <- rev(lapply(.variables, id_var, drop = drop))
  p <- length(ids)
  ndistinct <- vapply(ids, attr, 'n', FUN.VALUE = numeric(1), USE.NAMES = FALSE)
  n <- prod(ndistinct)
  if (n > 2^31) {
    char_id <- inject(paste(!!!ids, sep = '\r'))
    res <- match(char_id, unique0(char_id))
  }
  else {
    combs <- c(1, cumprod(ndistinct[-p]))
    mat <- inject(cbind(!!!ids))
    res <- c((mat - 1L) %*% combs + 1L)
  }
  if (drop) {
    id_var(res, drop = TRUE)
  }
  else {
    res <- as.integer(res)
    attr(res, 'n') <- n
    res
  }
}

# Use chartr() for safety since toupper() fails to convert i to I in Turkish locale
lower_ascii <- "abcdefghijklmnopqrstuvwxyz"
upper_ascii <- "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
to_lower_ascii <- function(x) chartr(upper_ascii, lower_ascii, x)
to_upper_ascii <- function(x) chartr(lower_ascii, upper_ascii, x)

tolower <- function(x) {
  cli::cli_abort("Please use {.fn to_lower_ascii}, which works fine in all locales.")
}

toupper <- function(x) {
  cli::cli_abort("Please use {.fn to_upper_ascii}, which works fine in all locales.")
}

# Convert a snake_case string to camelCase
camelize <- function(x, first = FALSE) {
  x <- gsub("_(.)", "\\U\\1", x, perl = TRUE)
  if (first) x <- firstUpper(x)
  x
}

snakeize <- function(x) {
  x <- gsub("([A-Za-z])([A-Z])([a-z])", "\\1_\\2\\3", x)
  x <- gsub(".", "_", x, fixed = TRUE)
  x <- gsub("([a-z])([A-Z])", "\\1_\\2", x)
  to_lower_ascii(x)
}

firstUpper <- function(s) {
  paste0(to_upper_ascii(substring(s, 1, 1)), substring(s, 2))
}

snake_class <- function(x) {
  snakeize(class(x)[1])
}

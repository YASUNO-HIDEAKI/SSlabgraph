#' @title graph for soil science lab
#' @description
#' \code{boxplot} create boxplot
#'
#' @importFrom dplyr %>%
#' @import ggplot2
#'
#' @param data use data
#' @param x x axis
#' @param y y axis
#' @param xlab x axis title name
#' @param ylab y axis title name
#' @param fill fill name You do not have to enter it if you do not need id
#' @param col color code
#' @return graph
#' @export
#' @examples
#' # boxplot(data = soil data, x = Treatment, y = CUE)

boxplot <- function(data, x, y, xlab, ylab, fill, col) {

        if(missing(fill)) {

                graph.data <-
                        data %>%
                        dplyr::select(id = {{x}}, val = {{y}})

                graph <-
                        graph.data %>%
                        ggplot(aes(x = id, y = val)) +
                        geom_boxplot(outlier.colour = NA) +
                        geom_jitter(aes(x = id, y = val),
                                    width = 0.2) +
                        theme_classic(base_size = 20) +
                        theme(axis.title = element_text(color = "black"),
                              axis.line = element_line(color = "black"),
                              axis.text = element_text(color = "black"))

        }else{

                graph.data <-
                        data %>%
                        dplyr::select(id = {{x}}, val = {{y}}, fill = {{fill}})

                graph <-
                        graph.data %>%
                        ggplot(aes(x = id, y = val, fill = fill)) +
                        geom_boxplot(outlier.color = NA) +
                        geom_jitter(aes(x = id, y = val),
                                    position = position_jitterdodge(dodge.width = 0.55,
                                                                    jitter.width = 0.2)) +
                        theme_classic(base_size = 20) +
                        theme(axis.title = element_text(color = "black"),
                              axis.line = element_line(color = "black"),
                              axis.text = element_text(color = "black"),
                              legend.title = element_blank())

                if(missing(col)) {

                }else{

                        graph <-
                                graph +
                                scale_fill_manual(values = col)

                        }

        }

        if(missing(xlab)) {

                graph <-
                        graph +
                        theme(axis.title.x = element_blank()) +
                        labs(y = ylab)

        }else{

                graph <-
                        graph +
                        labs(x = xlab, y = ylab)

        }

        print(graph)
        boxgraph <<- graph

}


#' @title NMDS analysis
#' @description
#' \code{f.NMDS.analysis} NMDS analysis
#'
#' @importFrom dplyr %>%
#' @import vegan
#' @importFrom GerminaR textcolor
#'
#' @param data use data
#' @param loc location data
#' @return nmds.result
#' @return bata.dist
#' @export
#' @examples
#' # f.NMDS.analysis(data = input, loc = loc)

f.NMDS.analysis <- function(data, loc) {

        beta.dist <- vegdist(data, method = "bray")
        GerminaR::textcolor("Result of beta.dist", fg = "blue") %>%
                message()
        print(beta.dist)

        nmds.result <- metaMDS(beta.dist, distance = "bray")

        GerminaR::textcolor("Result of metaMDS \n Stress value of <0.2 indicate a good fit of the model", fg = "blue") %>%
                message()
        print(nmds.result)
        nmds.result <<- nmds.result
        plot(nmds.result, type = "t", display = "site")

        adonis.result <- adonis2(beta.dist~loc[, 2],permutation=10000)
        GerminaR::textcolor("Result of adonis \n
                            SumofSqs = Total sum of squars \n
                            F = F value \n
                            R2 indicate that location can extimate ~~%. \n
                            Pr value of <0.05 indicate the significant different of β diversity among location",
                            fg = "blue") %>%
                message()
        print(adonis.result)

        dispaaesion <- betadisper(beta.dist, loc[, 2])
        anova.result <- anova(dispersion)
        GerminaR::textcolor("Result of anova", fg = "blue") %>%
                message()
        print(anova.result)

}

#' @title NMDS graph
#' @description \code{f.NMDS.graph} create NMDS plot
#'
#' @importFrom dplyr %>%
#' @import ggplot2
#'
#' @param data Enter the "data.score" obtained from "f.nmds.result"
#' @param color Enter the color name or hexadecimal color code. You can omit.
#' @param shape Enter the shape number. You can omit.
#'
#' @export
#' @return NMDS.graph
#'
#' @examples
#' # NMDS.graph(data = data.score)
#' # NMDS.graph(data = data.score, color = c("#0000ff", "#ffa500), shape = c(1, 2))
#' # NMDS.graph(data = data.score, env = env.vec)
#'

f.NMDS.graph <-
        function(data = nmds.result, color, shape) {

                score <- data %>%
                        scores() %>%
                        as.data.frame()

                id <- score %>%
                        rownames(.) %>%
                        stringr::str_sub(., end = -2)

                score <- cbind(score, id)

                graph <-
                        score %>%
                        ggplot(aes(x = NMDS1, y = NMDS2, color = id, shape = id)) +
                        geom_hline(yintercept = 0,
                                   linetype = "dashed",
                                   size = 0.5,
                                   color = "black") +
                        geom_vline(xintercept = 0,
                                   linetype = "dashed",
                                   size = 0.5,
                                   color = "black") +
                        geom_point(stat = "identity",
                                   size = 5,
                                   stroke = 1.5) +
                        theme_test(base_rect_size = 1.5,　
                                   base_line_size = 1) +
                        theme(legend.text = element_text(size = 20),　
                              legend.key.size = unit(1.2, "cm"),　#凡例の大きさ
                              legend.title = element_blank(), #凡例タイトルの大きさ
                              axis.title = element_text(size = 18),　#軸タイトルの大きさ
                              axis.text = element_text(size = 20, color = "black"),　#軸ラベルの大きさ
                              plot.margin = unit(c(1,1,1,1), "lines"))


                if(missing(color) & missing(shape)) {

                        NMDS.graph <<- graph
                        print(graph)

                }else if(missing(color)) {

                        graph <-
                                graph +
                                scale_shape_manual(values = shape)

                        NMDS.graph <<- graph
                        print(graph)

                }else if(missing(shape)) {

                        graph <-
                                graph +
                                scale_color_manual(values = color)

                        NMDS.graph <<- graph
                        print(graph)

                }else{

                        graph <-
                                graph +
                                scale_shape_manual(value = shape) +
                                scale_color_manual(value = color)

                        NMDS.graph <<- graph
                        print(graph)

                }
        }

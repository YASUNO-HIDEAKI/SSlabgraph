#' @title NMDS analysis
#' @description \code{f.NMDS.analysis} NMDS analysis
#'
#' @param data Amplicon or PLFA data
#' @param dttype You choice "A" or "P". If you analyse amplicon data, you choice "A". If you analyse PLFA data, you choice "P".
#' @param subsamplesize You enter sabsamplesize
#' @param loc location data. You read location data sheet.
#'
#' @export
#' @return data.score
#' @return nmds.result
#'
#' @examples
#' # f.NMDS.analysis(data = input, dytype = "A", subsamplesize = 20000, loc = loc)


f.NMDS.analysis <-
        function(data, dttype, subsamplesize, loc) {

                if(dtype == "P") {

                        input <- data

                        id <- input %>%
                                rownames(.) %>%
                                stringr::str_sub(., end = -2)

                        id <- as.data.frame(id, row.names = names("id"))

                        input2 <- cbind(input, id)

                        input2 <<- input2

                }else {

                        input <- data %>%
                                  t()

                        input.excel.5OTU <- subset(input, rowSums(input) > 5) %>%
                                             t()

                        input.cleaned <- subset(input.excel.5OTU, rowSums(input.excel.5OTU) > 5) %>%
                                          t()

                        subsamplesize <- subsamplesize

                        tobe.rarefied <- subset(input.cleaned, rowSums(input.cleaned) >= subsamplesize)

                        rarefied <- rrarefy(tobe.rarefied, subsamplesize)

                        mean <- rowSums(rarefied) %>%
                                 mean()

                        min <- rowSums(rarefied) %>%
                                min()

                        input <- subset(t(rarefied), rowSums(t(rarefied)) > 0) %>%
                                  t()

                        id <- input %>%
                                rownames(.) %>%
                                stringr::str_sub(., end = -2)

                        input2 <- cbind(input, id)

                        input2 <<- input2
                        print(mean)
                        print(min)

                beta.dist <- vegdist(input2, method = "bray")

                nmds.result <- metaMDS(input2, distance = "bray")
                nmds.result <<- nmds.result

                print(nmds.result)

                loc <- loc

                perANOVA <-adonis(beta.dist ~ loc$id, permutations = 10000)

                print(perANOVA)

                data.score <- nmds.result %>%
                               scores() %>%
                               as.data.frame()

                data.score <- cbind(data.score, loc)

                data.score <<- data.score

                }

        }

#' @title Envfit analysis
#' @description \code{f.envfit.analysis} Envfit analysis
#'
#' @param data Enter the "nmds.result" obtained from "f.NMDS.analysis
#' @param env Environment data. You read Environmental data sheet.
#'
#' @export
#' @return env.vec
#'
#' @examples
#' # environment <- read.csv(environment.csv, header = T, stringAsFactor = T)
#' #f.envfit.analysis(data = nmds.resuslt, env = environment)
#'

f.envfit.analysis <-
        function(data, env) {

                nmds.result <- data
                env <- env

                env.fit <- envfit(nmds.result, env, permu = 10000)

                env.vec <- scores(env.fit, display = "vectors") %>%
                            as.data.frame()

                env.vec <- cbind(env.vec, vecname = rownames(env.vec))

                env.vec <<- env.vec

        }

#' @title NMDS graph
#' @description \code{f.NMDS.graph} create NMDS plot
#'
#' @param data Enter the "data.score" obtained from "f.nmds.result"
#' @param env Enter the "env.vec" obtained from "f.envfit.analysis". You can omit.
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
        function(data, env, color, shape) {

                graph <-
                        data %>%
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
                                   size = 7,
                                   stroke = 3) +
                        theme_test(base_rect_size = 1.5,　
                                   base_line_size = 1) +
                        theme(legend.text = element_text(size = 24),　
                              legend.key.size = unit(1.2, "cm"),　#凡例の大きさ
                              legend.title = element_text(size = 20), #凡例タイトルの大きさ
                              axis.title = element_text(size = 24),　#軸タイトルの大きさ
                              axis.text = element_text(size = 24, color = "black"),　#軸ラベルの大きさ
                              plot.margin = unit(c(1,1,1,1), "lines"))

                if(missing(env)) {

                }else{

                        graph <-
                                graph +
                                geom_segment(data = env,
                                             aes(x = 0, xend = NMDS1, y = 0, yend = NMDS2),
                                             arrow = arrow(length = unit(0.25, "cm")),
                                             color = "black") +
                                geom_text(data = env,
                                          aes(x = NMDS1,
                                              y = NMDS2,
                                              label = vecname),
                                          size = 3)


                }

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



f.NMDS.dataset <-
        function(data, dttype, subsamplesize) {

                if(dtype == "P") {

                        input <- data

                        id <-
                                input %>%
                                rownames(.) %>%
                                stringr::str_sub(., end = -2)

                        id <-
                                as.data.frame(id, row.names = names("id"))

                        input2 <-
                                cbind(input, id)

                        input2 <<- input2

                }else {

                        input <-
                                data %>%
                                t()

                        input.excel.5OTU <-
                                subset(input, rowSums(input) > 5) %>%
                                t()

                        input.cleaned <-
                                subset(input.excel.5OTU, rowSums(input.excel.5OTU) > 5) %>%
                                t()

                        subsamplesize <- subsamplesize

                        tobe.rarefied <-
                                subset(input.cleaned, rowSums(input.cleaned) >= subsamplesize)

                        rarefied <-
                                rrarefy(tobe.rarefied, subsamplesize)

                        mean <-
                                rowSums(rarefied) %>%
                                mean()

                        min <-
                                rowSums(rarefied) %>%
                                min()

                        input <-
                                subset(t(rarefied), rowSums(t(rarefied)) > 0) %>%
                                t()

                        id <-
                                input %>%
                                rownames(.) %>%
                                stringr::str_sub(., end = -2)

                        input2 <-
                                cbind(input, id)

                        input2 <<- input2
                        print(mean)
                        print(min)

                }
        }

f.NMDS.analysis <-
        function(input2, loc) {

                beta.dist <-
                        vegdist(input, method = "bray")

                nmds.result <-
                        metaMDS(input, distance = "bray")
                print(nmds.result)

                loc <- loc

                perANOVA <-
                        adonis(beta.dist ~ loc$id,
                               permutations = 10000)

                print(perANOVA)

                data.score <- 　　　#nmds.resultからNMDSのX軸Y軸の値を取得
                        nmds.result %>%
                        scores() %>%
                        as.data.frame()

                data.score <-
                        cbind(data.score, loc)

                data.score <<- data.score

        }

f.envfit.analysis <-
        function(nmds.result, env) {

                env <- env

                env.fit <-
                        envfit(nmds.result, env, permu = 10000)

                env.vec <-
                        scores(env.fit, display = "vectors") %>%
                        as.data.frame()

                env.vec <-
                        cbind(env.vec, vecname = rownames(env.vec))

                env.vec <<- env.vec

        }

NMDS.graph <-
        function(data, env) {

                if(missing(env)) {

                        NMDS.graph <-
                                data %>%
                                ggplot(.,
                                       aes(x = NMDS1,
                                           y = NMDS2,
                                           color = id,
                                           shape = id)) +
                                geom_hline(yintercept = 0,
                                           linetype = "dashed",
                                           size = 0.5,
                                           color = "black") +
                                geom_vline(xintercept = 0,
                                           linetype = "dashed",
                                           size = 0.5,
                                           color = "black") +
                                geom_point(stat = "identity",
                                           size = 7, 　#プロットの大きさ
                                           stroke = 3) +  #プロットの枠線の太さ　
                                theme_test(base_rect_size = 1.5,　#グラフスタイル
                                           base_line_size = 1) +
                                theme(legend.text = element_text(size = 24),　#凡例の文字サイズ
                                      legend.key.size = unit(1.2, "cm"),　#凡例の大きさ
                                      legend.title = element_text(size = 20), #凡例タイトルの大きさ
                                      axis.title = element_text(size = 24),　#軸タイトルの大きさ
                                      axis.text = element_text(size = 24, color = "black"),　#軸ラベルの大きさ
                                      plot.margin = unit(c(1,1,1,1), "lines")) #図の余白

                        NMDS.graph <<- NMDS.graph
                        print(NMDS.graph)

                }else{

                        NMDS.graph.env <-
                                data %>%
                                ggplot(.,
                                       aes(x = NMDS1,
                                           y = NMDS2,
                                           color = id,
                                           shape = id)) +
                                geom_hline(yintercept = 0,
                                           linetype = "dashed",
                                           size = 0.5,
                                           color = "black") +
                                geom_vline(xintercept = 0,
                                           linetype = "dashed",
                                           size = 0.5,
                                           color = "black") +
                                geom_point(stat = "identity",
                                           size = 7, 　#プロットの大きさ
                                           stroke = 3) +  #プロットの枠線の太さ　
                                geom_segment(data = env.vec,
                                             aes(x = 0, xend = NMDS1, y = 0, yend = NMDS2),
                                             arrow = arrow(length = unit(0.25, "cm")),
                                             color = "black") +
                                geom_text(data = env.vec,
                                          aes(x = NMDS1,
                                              y = NMDS2,
                                              label = vecname),
                                          size = 3) +
                                theme_test(base_rect_size = 1.5,　#グラフスタイル
                                           base_line_size = 1) +
                                theme(legend.text = element_text(size = 24),　#凡例の文字サイズ
                                      legend.key.size = unit(1.2, "cm"),　#凡例の大きさ
                                      legend.title = element_text(size = 20), #凡例タイトルの大きさ
                                      axis.title = element_text(size = 24),　#軸タイトルの大きさ
                                      axis.text = element_text(size = 24, color = "black"),　#軸ラベルの大きさ
                                      plot.margin = unit(c(1,1,1,1), "lines"))

                        NMDS.graph.env <<- NMDS.graph.env
                        print(NMDS.graph.env)


                }
        }

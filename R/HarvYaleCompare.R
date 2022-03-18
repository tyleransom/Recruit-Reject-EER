library(tidyverse)
library(tabulizer)
library(magrittr)
library(RColorBrewer)
library(ggthemes)

#------------------------------------------------------------------------------
# DATA: Harvard admission statistics from plaintiff's expert witness rebuttal report
#------------------------------------------------------------------------------
docurl <- "https://samv91khoyt2i553a2t1s05i-wpengine.netdna-ssl.com/wp-content/uploads/2018/06/Doc-415-2-Arcidiacono-Rebuttal-Report.pdf"

tb.5.1r <- extract_tables(docurl, pages=147, method = "stream") %>% pluck(1) %>% as_tibble %>%
  rename(decile=V1, w.n=V2, b.n=V3, h.n=V4, a.n=V5, t.n=V6, w.shr=V7, b.shr=V8, h.shr=V9, a.shr=V10, t.shr=V11) %>%
  mutate_at(vars(w.n, b.n, h.n, a.n, t.n, w.shr, b.shr, h.shr, a.shr, t.shr),~as.numeric(gsub(",","",.)))

tb.5.2r <- extract_tables(docurl, pages=148, method = "stream") %>% pluck(1) %>% as_tibble %>%
  rename(decile=V1, w.adm.r=V2, b.adm.r=V3, h.adm.r=V4, a.adm.r=V5, t.adm.r=V6) %>%
  mutate_at(vars(w.adm.r, b.adm.r, h.adm.r, a.adm.r, t.adm.r),~as.numeric(gsub("\\%","",.)))


#------------------------------------------------------------------------------
# DATA: Yale admission statistics from DOJ complaint
#------------------------------------------------------------------------------
test <- extract_tables('https://www.justice.gov/opa/press-release/file/1326306/download', pages = 23, method = "stream") %>% 
    `[[`(1) %>%
    as_tibble

test %<>% filter(V2!="")

app <- test %>% slice(c(2,5,8,11,14,17,20,23,26,29)) %>%
    mutate_all(~str_replace_all(.,"\\(","")) %>%
    mutate_all(~str_replace_all(.,"\\)","")) %>%
    mutate_all(~str_replace_all(.,",","")) %>%
    mutate(V1 = seq(10,1)) %>%
    mutate_all(~as.numeric(.))

adm <- test %>% slice(c(3,6,9,12,15,18,21,24,27)) %>%
    mutate_all(~str_replace_all(.,"\\[","")) %>%
    mutate_all(~str_replace_all(.,"\\]","")) %>%
    mutate_all(~str_replace_all(.,",","")) %>%
    mutate(V1 = seq(10,2)) %>%
    mutate_all(~as.numeric(.)) %>%
    add_row(V1 = 1, V2 = 4, V3 = 3, V4 = 1, V5 = 1, V6 = 10)

apptot <- app %>% summarize(w.app = sum(V2),
                            a.app = sum(V3),
                            b.app = sum(V4),
                            h.app = sum(V5))
admtot <- adm %>% summarize(w.adm = sum(V2),
                            a.adm = sum(V3),
                            b.adm = sum(V4),
                            h.adm = sum(V5))
admtot/apptot %>% print

ar <- adm/app

ar %<>% mutate(
    White = V2,
    `Asian American` = V3,
    `African American` = V4,
    Hispanic = V5,
    Total = V6,
    Decile = c(10,9,8,7,6,5,4,3,2,1)) 
    
ar %<>% select(Decile,White,`Asian American`,`African American`,Hispanic)
ar %<>% pivot_longer(-Decile,names_to = "Group", values_to = "admrate") %>%
    mutate(admrate = admrate*100,
           Group = factor(Group,levels=c("Asian American","White","Hispanic","African American")))


appshr <- app %>% mutate(
    White = V2/V6,
    `Asian American` = V3/V6,
    `African American` = V4/V6,
    Hispanic = V5/V6,
    Decile = V1) 

appshr %<>% select(Decile,White,`Asian American`,`African American`,Hispanic)

appshr %<>% pivot_longer(-Decile,names_to = "race", values_to = "share") %>%
    mutate(share = share*100)


#------------------------------------------------------------------------------
# FIGURE: Yale distribution of race by AI decile
#------------------------------------------------------------------------------
g <- ggplot(data=appshr, aes(x=Decile, y=share, fill=race))
g + geom_col(color = "black", size=0.05) +
    labs(x = NULL, y = "Composition of Decile", fill = "Group") + theme_bw() +
    theme(panel.grid.minor = element_blank(), panel.grid.major.y = element_line(size = 0.05), panel.grid.major.x = element_blank(), axis.ticks.x = element_blank(), axis.text.y = element_text(color = "black"), axis.text.x = element_text(angle = 0, hjust = 0.5, color = "black"), axis.title.x = element_text(color = "black"), axis.title.y = element_text(color = "black"), legend.position = "bottom") +
    scale_x_continuous(breaks=seq(1,10), labels=c("1","2","3","4","5","6","7","8","9","10")) +
    scale_fill_manual(values=rev(brewer.pal(9,"Blues")[seq(1,9,2)]))
ggsave("../FiguresAndTables/AIrepYale.pdf", device = "pdf", width=7.75, height = 6, units = "in")

#------------------------------------------------------------------------------
# FIGURE: Yale admit rates by race and AI decile
#------------------------------------------------------------------------------
g <- ggplot(data=ar %>% filter(Group %in% c("White","African American","Hispanic","Asian American")), aes(x=Decile, y=admrate))
g + geom_line(aes(color=Group)) +
  labs(x = "Academic Index Decile", y = "Admit Rate", linetype = NULL) + theme_minimal() +  
  theme(panel.grid.minor = element_blank(), panel.grid.major.y = element_line(size = 0.05), panel.grid.major.x = element_line(size = 0.05), axis.text.y = element_text(color = "black"), axis.text.x = element_text(color = "black"), axis.title.x = element_text(color = "black"), axis.title.y = element_text(color = "black"), legend.position="bottom", panel.border = element_rect(color="black", fill=NA)) + 
  scale_x_continuous(breaks=seq(1,10), labels=c("1","2","3","4","5","6","7","8","9","10")) + scale_color_colorblind() + scale_y_continuous(limits = c(0,62), breaks = seq(0,60,by=10))
ggsave("../FiguresAndTables/AIadmrateYale.pdf", device = "pdf", width=7.75, height = 6, units = "in")




#------------------------------------------------------------------------------
# FIGURE: Harvard admit rates by race and AI decile
#------------------------------------------------------------------------------
admrat <- tb.5.2r %>% mutate(
  White = w.adm.r,
  `Asian American` = a.adm.r,
  `African American` = b.adm.r,
  Hispanic = h.adm.r,
  Decile = decile) 

admrat %<>% select(Decile,White,`Asian American`,`African American`,Hispanic) %>%
            filter(Decile!="Total") %>%
            mutate_if(is.character,~as.numeric(.))

admrat %<>% select(Decile,White,`Asian American`,`African American`,Hispanic)
admrat %<>% pivot_longer(-Decile,names_to = "Group", values_to = "admrate") %>%
            mutate(Group = factor(Group,levels=c("Asian American","White","Hispanic","African American")))

g <- ggplot(data=admrat %>% filter(Group %in% c("White","African American","Hispanic","Asian American")), aes(x=Decile, y=admrate))
g + geom_line(aes(color=Group)) +
  labs(x = "Academic Index Decile", y = "Admit Rate", linetype = NULL) + theme_minimal() +  
  theme(panel.grid.minor = element_blank(), panel.grid.major.y = element_line(size = 0.05), panel.grid.major.x = element_line(size = 0.05), axis.text.y = element_text(color = "black"), axis.text.x = element_text(color = "black"), axis.title.x = element_text(color = "black"), axis.title.y = element_text(color = "black"), legend.position="bottom", panel.border = element_rect(color="black", fill=NA)) + 
  scale_color_colorblind() + scale_y_continuous(limits = c(0,62), breaks = seq(0,60,by=10)) + scale_x_continuous(breaks=seq(1,10), labels=c("1","2","3","4","5","6","7","8","9","10"))
ggsave("../FiguresAndTables/AIadmrateHarv.pdf", device = "pdf", width=7.75, height = 6, units = "in")

#------------------------------------------------------------------------------
# FIGURE: Harvard distribution of race by AI decile
#------------------------------------------------------------------------------
appshr <- tb.5.1r %>% mutate(
  tot = w.n+a.n+b.n+h.n,
  White = w.n/tot,
  `Asian American` = a.n/tot,
  `African American` = b.n/tot,
  Hispanic = h.n/tot,
  Decile = decile) 

appshr %<>% select(Decile,White,`Asian American`,`African American`,Hispanic) %>%
            filter(Decile!="Total") %>%
            mutate_if(is.character,~as.numeric(.))
        

appshr %<>% pivot_longer(-Decile,names_to = "race", values_to = "share") %>%
  mutate(share = share*100)

g <- ggplot(data=appshr, aes(x=Decile, y=share, fill=race))
g + geom_col(color = "black", size=0.05) +
  labs(x = NULL, y = "Composition of Decile", fill = "Group") + theme_bw() +
  theme(panel.grid.minor = element_blank(), panel.grid.major.y = element_line(size = 0.05), panel.grid.major.x = element_blank(), axis.ticks.x = element_blank(), axis.text.y = element_text(color = "black"), axis.text.x = element_text(angle = 0, hjust = 0.5, color = "black"), axis.title.x = element_text(color = "black"), axis.title.y = element_text(color = "black"), legend.position = "bottom") +
  scale_x_continuous(breaks=seq(1,10), labels=c("1","2","3","4","5","6","7","8","9","10")) +
  scale_fill_manual(values=rev(brewer.pal(9,"Blues")[seq(1,9,2)]))
ggsave("../FiguresAndTables/AIrepHarv.pdf", device = "pdf", width=7.75, height = 6, units = "in")



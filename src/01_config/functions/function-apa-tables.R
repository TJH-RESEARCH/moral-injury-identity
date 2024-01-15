


kbl_apa <- 
  function(data) {
  data %>
      format = "html",
     col.names = c("Category","n","%"),
      align = "l") %>%
  kableExtra::kable_classic(full_width = F, html_font = "times")
}
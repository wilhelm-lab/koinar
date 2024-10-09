library(httptest)
unzip("mAPI_batch.zip")
set_requester(function(request) {
  request <- gsub_request(request, "koina.wilhelmlab.org", "k.w.org")
  request <- gsub_request(request, "dlomix.fgcz.uzh.ch", "d.f.u.ch")
  request <- gsub_request(request, "Prosit_2019_intensity", "P_29_int")
})

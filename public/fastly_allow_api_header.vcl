sub vcl_recv {
  if (req.http.X-Spree-Token) {
    if (req.url ~ "\?") {
      set req.url = req.url "&token=" req.http.X-Spree-Token;
    } else {
      set req.url = req.url "?token=" req.http.X-Spree-Token;
    }
  }
  #FASTLY recv
}
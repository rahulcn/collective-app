if (typeof console == "undefined") {
    var console = {
        log: function() {}
    }
}

$.fn.socialShare = (function(e) {
    sharebars = [];
    e(document).ready(function() {
        e("div.supersocialshare").each(function() {
            sharebars.push(ShareBar(this))
        })
    });
    ShareBar = function(t) {
        var n = this,
            r = t,
            i = [],
            s = document.URL,
            o = "bubble",
            u = "flat",
            a = "arc",
            f = 0,
            l = 80,
            c = 50,
            h = "",
            p = "false",
            d = ["gradient", "flat", "light", "dark"];
        if (e(r).attr("data-url")) s = e(r).attr("data-url");
        if (e(r).attr("data-networks")) i = e(r).attr("data-networks").split(",");
        if (e(r).attr("data-style")) o = e(r).attr("data-style");
        if (e(r).attr("data-theme")) u = e(r).attr("data-theme").toLowerCase();
        if (d.indexOf(u) === -1) u = "gradient";
        if (e(r).attr("data-orientation")) a = e(r).attr("data-orientation");
        if (e(r).attr("data-angle")) f = parseInt(e(r).attr("data-angle"));
        if (e(r).attr("data-radius")) l = parseInt(e(r).attr("data-radius"));
        if (e(r).attr("data-gap")) c = parseInt(e(r).attr("data-gap"));
        if (e(r).attr("data-title")) h = e(r).attr("data-title");
        if (e(r).attr("data-open")) p = e(r).attr("data-open").toLowerCase();
        p = p != "false";
        init = function() {
            if (!v[o]) {
                console.log("ShareBar | INFO:Invalid style supplied. Exiting.");
                return
            }
            e(r).addClass(o).addClass("sss-" + u);
            template = v[o];
            e(r).html(template["holder"]);
            var t = e(r).find(".sb_network_holder");
            for (var n = 0; n < i.length; n++) {
                var a = i[n];
                if (!g[a]) {
                    console.log("Unsupported Network specified. Skipping.");
                    continue
                }
                var f = g[a];
                var l = f["url"].replace(/\[URL\]/gi, encodeURIComponent(s)).replace(/\[SHARETITLE\]/gi, encodeURIComponent(h));
                var c = template["network_button"].replace(/\[SHARE_URL\]/gi, l).replace(/\[NAME\]/gi, f["name"]).replace(/\[NETWORK\]/gi, a);
                var d = e(c);
                d.click(function(t) {
                    var n = g[e(this).attr("data-network")];
                    if (n["window"] && e(this).attr("href") && e(this).attr("target") == "_blank") {
                        t.preventDefault();
                        window.open(e(this).attr("href"), n["name"], n["window"])
                    }
                });
                t.append(d)
            }
            if (m[o]) m[o](template);
            if (p) e(r).find(".sb_main").click()
        };
        var v = {
            bubble: {
                holder: '<a class="sb_main" title="Share" alt="Share">Share</a>' + '<div class="sb_network_holder"></div>',
                network_button: '<a class="sb_network_button [NETWORK]" target="_blank" href="[SHARE_URL]" data-network="[NETWORK]">[NAME]</a>',
                orientations: {
                    arc: function() {
                        if (e(this).hasClass("disabled")) return;
                        var t = 250;
                        var n = 250;
                        var i = e(r).find(".sb_network_button").length;
                        var s = t + (i - 1) * n;
                        var o = 0;
                        var u = e(this).width();
                        var a = e(this).height();
                        var c = e(r).find(".sb_network_button:eq(0)").width();
                        var h = e(r).find(".sb_network_button:eq(0)").height();
                        var p = (u - c) / 2;
                        var d = (a - h) / 2;
                        if (!e(this).hasClass("active")) {
                            e(this).addClass("disabled").delay(s).queue(function(t) {
                                e(this).removeClass("disabled").addClass("active");
                                t()
                            });
                            var v = f;
                            var m = 180;
                            var g = m / i;
                            var y = v + g / 2;
                            e(r).find(".sb_network_button").each(function() {
                                var r = y / 180 * Math.PI;
                                var i = p + l * Math.cos(r);
                                var s = d + l * Math.sin(r);
                                e(this).css({
                                    display: "block",
                                    left: p + "px",
                                    top: d + "px"
                                }).stop().delay(n * o).animate({
                                    left: i + "px",
                                    top: s + "px"
                                }, t);
                                y += g;
                                o++
                            })
                        } else {
                            o = i - 1;
                            e(this).addClass("disabled").delay(s).queue(function(t) {
                                e(this).removeClass("disabled").removeClass("active");
                                t()
                            });
                            e(r).find(".sb_network_button").each(function() {
                                e(this).stop().delay(n * o).animate({
                                    left: p,
                                    top: d
                                }, t);
                                o--
                            })
                        }
                    },
                    line: function() {
                        if (e(this).hasClass("disabled")) return;
                        var t = 500;
                        var n = 250;
                        var i = e(r).find(".sb_network_button").length;
                        var s = c;
                        var o = t + (i - 1) * n;
                        var u = 1;
                        var a = e(this).width();
                        var l = e(this).height();
                        var h = e(r).find(".sb_network_button:eq(0)").width();
                        var p = e(r).find(".sb_network_button:eq(0)").height();
                        var d = (a - h) / 2;
                        var v = (l - p) / 2;
                        var m = f / 180 * Math.PI;
                        if (!e(this).hasClass("active")) {
                            e(this).addClass("disabled").delay(o).queue(function(t) {
                                e(this).removeClass("disabled").addClass("active");
                                t()
                            });
                            e(r).find(".sb_network_button").each(function() {
                                var r = d + (d + s * u) * Math.cos(m);
                                var i = v + (v + s * u) * Math.sin(m);
                                e(this).css({
                                    display: "block",
                                    left: d + "px",
                                    top: v + "px"
                                }).stop().delay(n * u).animate({
                                    left: r + "px",
                                    top: i + "px"
                                }, t);
                                u++
                            })
                        } else {
                            u = i;
                            e(this).addClass("disabled").delay(o).queue(function(t) {
                                e(this).removeClass("disabled").removeClass("active");
                                t()
                            });
                            e(r).find(".sb_network_button").each(function() {
                                e(this).stop().delay(n * u).animate({
                                    left: d,
                                    top: v
                                }, t);
                                u--
                            })
                        }
                    }
                }
            }
        };
        var m = {
            bubble: function(t) {
                var n = t["orientations"]["arc"];
                if (t["orientations"][a]) n = t["orientations"][a];
                e(r).find(".sb_main").click(n)
            }
        };
        var g = {
            facebook: {
                url: "http://www.facebook.com/sharer.php?u=[URL]",
                name: "Facebook",
                window: "width=500,height=311,scrollbars=no"
            },
            google: {
                url: "https://plus.google.com/share?url=[URL]",
                name: "Google Plus",
                window: "width=600,height=330,scrollbars=no"
            },
            twitter: {
                url: "https://twitter.com/intent/tweet?url=[URL]",
                name: "Twitter",
                window: "width=560,height=257,scrollbars=no"
            },
            pinterest: {
                url: "javascript:void((function(d)%7Bvar%20e%3Dd.createElement(%27script%27)%3Be.setAttribute(%27type%27,%27text/javascript%27)%3Be.setAttribute(%27charset%27,%27UTF-8%27)%3Be.setAttribute(%27src%27,%27//assets.pinterest.com/js/pinmarklet.js%3Fr%3D%27%2BMath.random()*99999999)%3Bd.body.appendChild(e)%7D)(document))%3B",
                name: "Pinterest"
            },
            linkedin: {
                url: "http://www.linkedin.com/shareArticle?mini=true&url=[URL]",
                name: "LinkedIn",
                window: "width=520,height=570,scrollbars=no"
            },
            email: {
                url: "mailto:?Subject=[SHARETITLE]&Body=[URL]",
                name: "E-Mail"
            }
        };
        n.url = s;
        n.me = t;
        n.networks = i;
        init()
    }
})(jQuery)
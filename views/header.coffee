div ".topbar", ->
  div ".fill", ->
    div ".container", ->

      a ".brand", href: "/", -> "site"

      ul ".secondary-nav", ->
        li ->
          a href: "/about/", -> "About"
        li class: "menu dropdown", ->
          li class: "menu dropdown", "data-dropdown": "dropdown", ->
            a ".menu", href: "#", -> "Dropdown"
            ul class: "menu-dropdown span5", ->
              li ->
                a href: "#", -> "Lorem"
              li class: "divider"
              li ->
                a href: "#", -> "Ipsum"
        li ->
          a href: "http://github.com/zachwill/zappa_template", -> "Github"

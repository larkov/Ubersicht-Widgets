command: "echo blurz"

refreshFrequency: 1000000000

style: """
  top: 1%
  left: 20%
  width: 200px
  height: 125px
  margin-left: -(@width / 2)
  overflow: hidden

  .content
    border-radius: 2px
    background: rgba(#fff, 0.5)
    color: #152033

    font-size: 40px
    line-height: @height
    font-family: Ubuntu
    text-align: center

  bg-blur = 10px

  .bg-slice
    position: absolute
    top: -(bg-blur)
    left: -(bg-blur)
    width: 100% + 2*bg-blur
    height: 100% + 2*bg-blur
    -webkit-filter: blur(bg-blur)
"""

render: (output) -> """
  <canvas class='bg-slice'></canvas>
  <div class='content'>#{output}</div>
"""

afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find '.bg-slice'
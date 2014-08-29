
# A widget to describe what's playing in either iTunes or Spotify.

command: "osascript 'media-now.widget/Get Current Track.scpt'"

refreshFrequency: 1000

style: """

  white05 = rgba(white,0.5)
  white01 = rgba(white,0.2)
  scale = 1
  bg-blur = 10px

  bottom: 18pt * scale
  left: 6pt * scale
  width: 325px * scale
  height: 120px * scale
  white-space: nowrap
  overflow: hidden
  text-overflow: ellipsis

  .wrapper
    font-family: HelveticaNeue
    text-align:left
    font-size:8pt * scale
    line-height: 1.6
    -webkit-font-smoothing: antialiased
    color: white
    background: white01
    border:1px * scale solid white05
    padding: 6px 12px * scale

  .bg-slice
    position: absolute
    bottom: -(bg-blur)
    left: -(bg-blur)
    width: 100% + 2*bg-blur
    height: 100% + 2*bg-blur
    -webkit-filter: blur(bg-blur)

  .song
    font-weight: 700

  .album
    color: white05

  .none
    display: none
  """

render: -> """
"""

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  # Get our pieces
  values=output.split(" ~ ")

  # Initialize our HTML.
  medianowHTML = ''

  # Loop through each of the pieces.
  # if values[0] != 'Nothing playing'
    # medianowHTML = "<div class='None'>hide dis shit</div>"
  # else

    # Create the DIVs for each piece of data.
  medianowHTML = "
      <canvas class='bg-slice'></canvas>
      <div class='wrapper'>
        <div class='artist'>" + values[0] + "</div>
        <div class='song'>" + values[1] + "</div>
        <div class='album'>" + values[2] + "</div>
        <div class='rating'>" + values[3] + "</div>
      </div>"

  # Set the HTML of our main DIV.
  div.html(medianowHTML)

  ###afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find '.bg-slice'###
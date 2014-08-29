
# A widget that shows what's currently playing in either iTunes or Spotify.

command: "osascript 'media-now.widget/Get Current Track.scpt'"

refreshFrequency: 1000

style: """

  white05 = rgba(white,0.5)
  white01 = rgba(white,0.2)
  scale = 1
  bg-blur = 10px

  bottom: (27pt + 6) * scale
  left: 6pt * scale
  width: 325px * scale
  height: 100px * scale
  overflow: hidden
  white-space: nowrap
  text-overflow: ellipsis
  // box-sizing: border-box

  .wrapper
    // box-sizing: border-box
    position: relative
    font-family: HelveticaNeue
    text-align:left
    font-size:8pt * scale
    line-height: 1.6
    -webkit-font-smoothing: antialiased
    color: white
    background: white01
    border:1px * scale solid white05
    padding: 6px 12px * scale
    z-index: 2

  .bg-slice
    position: absolute
    top: -(bg-blur)
    left: -(bg-blur)
    width: 100% + 2*bg-blur
    height: 100% + 2*bg-blur
    -webkit-filter: blur(bg-blur)

  .song
    font-weight: 700

  .album
    color: white05
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

  # Make it disappear if nothing is playing
  if values[0] == 'Nothing playing'
    medianowHTML = ""
  else

    # Create the DIVs for each piece of data.
    medianowHTML = "
      <div class='wrapper'>
        <div class='artist'>" + values[0] + "</div>
        <div class='song'>" + values[1] + "</div>
        <div class='album'>" + values[2] + "</div>
        <div class='rating'>" + values[3] + "</div>
      </div>
      <canvas class='bg-slice'></canvas>"

  # Set the HTML of our main DIV.
  div.html(medianowHTML)

  # afterRender: (domEl) ->
  # uebersicht.makeBgSlice(el) for el in $(domEl).find '.bg-slice'
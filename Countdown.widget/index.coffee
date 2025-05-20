command: "echo $((7200 - $(($(date +%s) % 7200))))"

refreshFrequency: 1000

render: (output) ->
  minutes = Math.floor(output / 60)
  seconds = output % 60
  """
  <div class='container'>
    <div class='title'>Next Cleanup In:</div>
    <div class='timer'>#{minutes}m #{seconds}s</div>
  </div>
  """

style: """
  top: 20px
  left: 20px
  color: #ffffff
  font-family: Helvetica Neue
  font-size: 24px
  background-color: rgba(0, 0, 0, 0.5)
  padding: 10px
  border-radius: 10px
  .title
    font-size: 14px
    color: #cccccc
  .timer
    font-size: 24px
    font-weight: bold
"""

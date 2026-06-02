// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

// On importe Chart.js
import Chart from 'chart.js/auto';

// On récupère le token CSRF nécessaire à Phoenix
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

// --- DÉFINITION DU HOOK DIRECTEMENT ICI ---
let Hooks = {}

Hooks.LineChart = {
  mounted() {
    const data = JSON.parse(this.el.dataset.points);

    this.chart = new Chart(this.el, {
      type: 'line',
      data: {
        labels: data.labels,
        datasets: [{
          label: this.el.getAttribute('data-label') || 'Données',
          data: data.values,
          borderColor: data.border_color || 'rgb(255, 212, 1)',
          backgroundColor: data.background_color || 'transparent',
          fill: true,
          tension: 0.3
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false
      }
    });
  },

  updated() {
    const data = JSON.parse(this.el.dataset.points);
    this.chart.data.labels = data.labels;
    this.chart.data.datasets[0].data = data.values;
    this.chart.update();
  }
}
// ------------------------------------------

// Configuration du LiveSocket avec nos Hooks intégrés
let liveSocket = new LiveSocket("/live", Socket, {
  params: {_csrf_token: csrfToken},
  hooks: Hooks
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
window.liveSocket = liveSocket

// The lines below enable quality of life phoenix_live_reload
if (process.env.NODE_ENV === "development") {
  window.addEventListener("phx:live_reload:attached", ({detail: reloader}) => {
    reloader.enableServerLogs()

    let keyDown
    window.addEventListener("keydown", e => keyDown = e.key)
    window.addEventListener("keyup", _e => keyDown = null)
    window.addEventListener("click", e => {
      if(keyDown === "c"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtCaller(e.target)
      } else if(keyDown === "d"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtDef(e.target)
      }
    }, true)

    window.liveReloader = reloader
  })
}
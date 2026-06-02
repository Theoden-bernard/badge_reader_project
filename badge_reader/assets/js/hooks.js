import Chart from 'chart.js/auto';

let Hooks = {}

Hooks.ThemeToggle = {
  mounted() {
    this.el.addEventListener("click", () => {
      const isDark = document.documentElement.getAttribute("data-theme") === "dark"
      const newTheme = isDark ? "light" : "dark"
      
      document.documentElement.setAttribute("data-theme", newTheme)
      localStorage.theme = newTheme
    })
  }
}

Hooks.GenericChart = {
  mounted() {
    const data = JSON.parse(this.el.dataset.points);
    let finalDatasets = [];

    if (data.datasets) {
      finalDatasets = data.datasets;
    } else {
      finalDatasets = [{
        label: data.label || 'Données',
        data: data.values || [],
        backgroundColor: data.background_colors || data.background_color || 'rgba(247, 220, 106, 0.2)',
        borderColor: data.border_colors || data.border_color || 'rgb(255, 212, 1)',
        borderWidth: data.type === 'doughnut' ? 1 : 2,
        fill: true,
        tension: 0.3
      }];
    }

    this.chart = new Chart(this.el, {
      type: data.type || 'line', 
      data: {
        labels: data.labels,
        datasets: finalDatasets
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { 
          legend: { 
            display: data.type === 'doughnut' || !!data.datasets,
            position: 'top'
          } 
        }
      }
    });
  },

  updated() {
    const data = JSON.parse(this.el.dataset.points);
    if (data.datasets) {
      this.chart.data.datasets = data.datasets;
    } else {
      this.chart.data.datasets[0].data = data.values;
      this.chart.data.datasets[0].backgroundColor = data.background_colors || data.background_color;
    }
    this.chart.data.labels = data.labels;
    this.chart.update();
  }
}

export default Hooks
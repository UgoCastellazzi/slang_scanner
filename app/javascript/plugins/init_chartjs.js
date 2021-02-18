const Chart = require("chart.js")

const init_chartjs = () => {
  const chartContainer = document.getElementById('chart-container');
  const ctx = document.getElementById('usageChart').getContext('2d');
  const chart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: JSON.parse(chartContainer.dataset.labels),
        datasets: [{
            label: 'Utilisations',
            backgroundColor: 'rgb(255, 238, 159)',
            data: JSON.parse(chartContainer.dataset.usage),
            hoverBackgroundColor: 'rgb(255, 208, 8)'
        }]
    },
    options: {
      legend: {
        display: false
      },
      scales: {
        xAxes: [{
          gridLines: {
              drawOnChartArea: false
          }
        }],
        yAxes: [{
          gridLines: {
              drawOnChartArea: false
          },
          scaleLabel: {
            display:true,
            labelString: "Utilisations",
            fontSize: '14',
          }
        }]
      }
    }
});
}

export { init_chartjs }
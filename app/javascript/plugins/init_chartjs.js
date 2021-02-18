const Chart = require("chart.js")

const init_chartjs = () => {
  const chartContainer = document.getElementById('chart-container');
  const ctx = document.getElementById('usageChart').getContext('2d');
  const chart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: JSON.parse(chartContainer.dataset.labels),
        datasets: [{
            label: 'Mentions',
            backgroundColor: 'rgb(255, 238, 159)',
            data: JSON.parse(chartContainer.dataset.usage),
            hoverBackgroundColor: 'rgb(255, 208, 8)'
        }]
    },
    options: {
      tooltips: {
        backgroundColor: 'rgb(255, 208, 8)',
        displayColors: false
      },
      legend: {
        display: false
      },
      scales: {
        xAxes: [{
          gridLines: {
              drawOnChartArea: false,
              drawTicks: false
          },
          ticks: {
            padding: 20
          }
        }],
        yAxes: [{
          gridLines: {
              drawOnChartArea: false,
              drawTicks: false
          },
          scaleLabel: {
            display:true,
            labelString: "Mentions",
            fontSize: '16',
            fontFamily: 'Roboto',
          },
          ticks: {
            padding: 10,
            min: 0
          }
        }]
      }
    }
  });
}

export { init_chartjs }
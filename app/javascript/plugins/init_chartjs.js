const Chart = require("chart.js")

const ctx = document.getElementById('usageChart').getContext('2d')

const manageEvent = (chart, index) => {
  const clickedMonth = chart.data.labels[index].replace(" ", "-").toLowerCase();
  const cardsToShow = document.querySelectorAll(`.song-card.${clickedMonth}`);
  const cardsToHide = document.querySelectorAll(`.song-card:not(.${clickedMonth})`);
  hideCards(cardsToHide);
  showCards(cardsToShow);
}

const hideCards = (cards) => {
  cards.forEach(card => {
    card.style.display = "none";
  });
}

const showCards = (cards) => {
  cards.forEach(card => {
    card.style.display = "flex";
  });
}

const init_chartjs = () => {
  const chartContainer = document.getElementById('chart-container');
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
      onClick: 
        function handleClick(evt) {
            const index = chart.getElementAtEvent(evt)[0]._index;
            manageEvent(chart, index);
        },
      tooltips: {
        backgroundColor: 'rgb(255, 208, 8)',
        displayColors: false,
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
            min: 0,
            autoSkip: false
          }
        }]
      }
    }
  });
}

export { init_chartjs }
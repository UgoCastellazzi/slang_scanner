const changeCardsDisplay = (chart, index) => {
  const clickedMonth = chart.data.labels[index].replace(" ", "-").toLowerCase();
  const cardsToShow = document.querySelectorAll(`.song-card.${clickedMonth}`);
  const cardsToHide = document.querySelectorAll(`.song-card:not(.${clickedMonth})`);
  hideCards(cardsToHide);
  showCards(cardsToShow);
}

const hideCards = (cards) => {
  cards.forEach(card => {
    card.parentNode.style.display = "none";
  });
}

const showCards = (cards) => {
  cards.forEach(card => {
    card.parentNode.style.display = "flex";
  });
}

export { changeCardsDisplay }
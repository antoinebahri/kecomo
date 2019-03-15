const searchBar = document.querySelector("#searchbar");
const resultsList = document.querySelector("#results");

searchBar.addEventListener('keyup', (event) => {
  while (resultsList.firstChild) {
    resultsList.removeChild(resultsList.firstChild);
  }

      data.words.forEach((result) => {
        const resu = `<li>${result}</li>`;
        resultsList.insertAdjacentHTML("beforeend", resu);
      });
    });
});

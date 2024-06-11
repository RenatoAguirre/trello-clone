import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

// Connects to data-controller="states"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }
  async changeName(e) {
    console.log(e.target.value);
    console.log(this.element);
    const ids = this.element.querySelector("input").id.split("-"); //ids[0] = "board", ids[1] = "state"
    await this.changeNameRequest(ids[0], ids[1], e.target.value);
  }
  async changeNameRequest(boardId, stateId, name) {
    //taken from .rubyonrails.org/working_with_javascript_in_rails.html 5.3 AJAX REQUEST
    //also data-actions are taken from https://stimulus.hotwired.dev/reference/actions
    const request = new FetchRequest(
      "PATCH",
      `http://127.0.0.1:3000/states/${stateId}`,
      {
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        body: JSON.stringify({
          state: { name: name },
        }),
        responseKind: "json",
      }
    );
    const response = await request.perform();
    if (response.ok) {
      const body = await response.text;
      console.log(body);
    }
    /*const request = new FetchRequest("update", )
    fetch(`//boards/${ids[0]}/states/${ids[1]}/edit/index`, {
      headers: {
        Accept: "application/json",
        "X-Requested-With": "XMLHttpRequest",
      },
    })
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        const resultDiv = document.getElementById("result");
        resultDiv.innerHTML = "";

        data.forEach((user) => {
          const userElement = document.createElement("li");
          userElement.textContent = user.name;
          resultDiv.appendChild(userElement);
        });
      })
      .catch((error) => {});*/
  }
}

import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  connect() {
    //console.log("task connected !");
  }
  async handleClick(e) {
    //const stateList = this.element.querySelector("");
    console.log(e.target.id);
    const stateId = e.target.id.split("-")[1];
    console.log(stateId);
    const taskId = e.target.id.split("-").at(-1);
    console.log(taskId);
    await this.changeTaskStateRequest(taskId, stateId);
  }
  async changeTaskStateRequest(taskId, stateId) {
    //taken from .rubyonrails.org/working_with_javascript_in_rails.html 5.3 AJAX REQUEST
    //also data-actions are taken from https://stimulus.hotwired.dev/reference/actions
    const request = new FetchRequest(
      "PATCH",
      `http://0.0.0.0:8080/tasks/${taskId}`,
      {
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        body: JSON.stringify({
          task: { state_id: stateId },
        }),
        responseKind: "html", //this is to tell the request that the response must be in json format
      }
    );
    const response = await request.perform();
    if (response.ok) {
      const body = await response.text;
      document.documentElement.innerHTML = body;
    }
  }
}

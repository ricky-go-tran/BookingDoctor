import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["wrapper", "template"];

  addServiceItem(event) {
    event.preventDefault();
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime());
    this.wrapperTarget.insertAdjacentHTML("beforeend", content);
  }

  removeServiceItem(event) {
    event.preventDefault();
    const wrapper = event.target.closest(".nested-fields");
    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove();
    } else {
      wrapper.querySelector("input[name*='_destroy']").value = 1;
      wrapper.style.display = "none";
    }
  }
}

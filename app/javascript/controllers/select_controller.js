import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];
  select() {
    window.location.href = "/users?type="+ this.selectTarget.dataset.content;
  }
}

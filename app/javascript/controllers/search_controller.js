import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source"];
  search() {
    let value = this.sourceTarget.value
    let url_search = this.sourceTarget.dataset.content
    if (value != "")
    {
      url_search += `?search=${value}`
    }
    window.location.href = url_search;
  }
  select() {
    console.log(this.sourceTarget.value)
    let value = this.sourceTarget.value
    let url_search = this.sourceTarget.dataset.content
    if (value != "all")
    {
      url_search += `?type=${value}`
      window.location.href = url_search;
    }  else {
      window.location.href = url_search;
    }

  }
}

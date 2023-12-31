import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer";

export default class extends Controller {
  static targets = ["source"];
  connect() {
    this.handle();
  }
  handle() {
    var data = this.getData();
    data = data.sort((item1, item2) => item1.start_time - item2.start_time);
    this.render(data);
  }
  getData() {
    return JSON.parse(this.sourceTarget.dataset.appointmentView);
  }
  render(data) {
    var table = document.getElementById("appointment-clinic-view");
    var body = table.getElementsByTagName("tbody")[0];
    body.innerHTML = "";
    for (let index = 0; index < data.length; index++) {
      let row = body.insertRow();
      let name = row.insertCell(0);
      name.innerHTML = data[index].patient_name;
      let start = row.insertCell(1);
      start.innerHTML = this.formatDateTime(data[index].start_time);
      let end = row.insertCell(2);
      end.innerHTML = this.formatDateTime(data[index].end_time);
      let detail = row.insertCell(3);
      detail.innerHTML = `<a class="detail" href="/clinic/appointments/${data[index].id}">Detail</a>`;
      let cancle = row.insertCell(4);
      cancle.innerHTML =
        "<a class='cancle' data-turbo-method='delete' data-turbo-confirm='Are you sure?' href='/clinic/appointments/" +
        data[index].id +
        "/cancle'>Cancle</a>";
    }
  }
  formatDateTime(dateTimeString) {
    const date = new Date(dateTimeString);

    const hours = date.getUTCHours().toString().padStart(2, "0");
    const minutes = date.getUTCMinutes().toString().padStart(2, "0");
    const day = date.getUTCDate().toString().padStart(2, "0");
    const month = (date.getUTCMonth() + 1).toString().padStart(2, "0"); // Tháng trong JavaScript bắt đầu từ 0
    const year = date.getUTCFullYear();

    return `${hours}:${minutes} ${day}/${month}/${year}`;
  }
}

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source"];
  connect() {
    this.handle();
  }
  handle() {
    var data = this.getData();
    this.render(data);
  }
  getData() {
    return JSON.parse(this.sourceTarget.dataset.paymentView);
  }
  render(data) {
    var div = document.getElementById("payment-patient-view");
    div.innerHTML = "";
    if (data.length > 0) {
      for (let index = 0; index < data.length; index++) {
        let wrapper = document.createElement("div");
        let left = document.createElement("div");
        let right = document.createElement("div");
        let title = document.createElement("div");
        let time = document.createElement("div");
        wrapper.classList.add("medical-record-item");
        left.classList.add("left");
        right.classList.add("right");
        title.classList.add("title");
        time.classList.add("time");

        title.innerHTML = `${data[index].clinic_name}`;
        time.innerHTML = `${data[index].start_time} - ${data[index].end_time}`;
        left.appendChild(title);
        left.appendChild(time);
        right.innerHTML = `<a class="view-details" href= "/pdfs/invoice/${data[index].id}">Get Details</a>
                            <a class="cancle" data-turbo-method='post ' href= "/patient/payments/${data[index].id}/checkout">Payment</a>`;
        wrapper.appendChild(left);
        wrapper.appendChild(right);
        div.appendChild(wrapper)
      }
      }else {
        let empty = document.createElement("div");
        empty.classList.add('empty')
        empty.innerHTML = "Invoices is empty..."
        div.appendChild(empty)
      }
      }
    }


import consumer from "channels/consumer";

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log("Connecting...");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var table = document.getElementById("appointment-clinic-view");
    var body = table.getElementsByTagName("tbody")[0];
    var datajson = JSON.parse(table.dataset.appointmentView);
    if (data.action == "add") {

      datajson.push(data.data);
      this.render(table, body, datajson)
    } else {
      datajson = datajson.filter((item) => {return  item.id !== data.data})
      this.render(table, body, datajson)
    }


  },
  render(table, body, datajson) {
    datajson = datajson.sort(
      (item1, item2) => new Date(item1.start_time) - new Date(item2.start_time)
    );
    table.dataset.appointmentView = JSON.stringify(datajson);
    body.innerHTML = "";
    for (let index = 0; index < datajson.length; index++) {
      let row = body.insertRow();
      let name = row.insertCell(0);
      name.innerHTML = datajson[index].patient_name;
      let start = row.insertCell(1);
      start.innerHTML = datajson[index].start_time;
      let end = row.insertCell(2);
      end.innerHTML = datajson[index].end_time;
      let detail = row.insertCell(3);
      detail.innerHTML = `<a class="detail" href="/clinic/appointments/${datajson[index].id}">Detail</a>`;
      let cancle = row.insertCell(4);
      cancle.innerHTML =
        "<a class='cancle' data-turbo-method='delete' data-turbo-confirm='Are you sure?' href='/clinic/appointments/" +
        datajson[index].id +
        "/cancle'>Cancle</a>";
    }
  },
});

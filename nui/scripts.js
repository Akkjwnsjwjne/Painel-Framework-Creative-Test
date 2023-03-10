$(function () {
  init();
  $("body").hide();
  const actionContainer = $("body");

  window.addEventListener("message", function (event) {
    const item = event.data;

    if (item.showmenu) {
      ResetMenu();
      actionContainer.show();
    }

    if (item.hidemenu) {
      actionContainer.hide();
      window.location.reload(true);
    }

    if (item.idcr) {
      let iduser = item.idcr;
      let nme = item.nmes;
      document.getElementById("idus").innerHTML = `ID: ${iduser}`;
      document.getElementById("nome").innerHTML = `NOME: ${nme}`;
    }

    if (item.psids) {
      let nomes = [item.psnomes];
      let ids = [item.psids];

      const lista = document.getElementById("nomes");

      for (const i = 0; i < nomes.length; i++) {
        const nome = nomes[i] + " #" + ids[i];
        const itemLista = document.createElement("li");
        itemLista.textContent = nome;
        lista.appendChild(itemLista);
      }
    }
  });

  document.onkeyup = function (data) {
    if (data.which === 27) {
      if (actionContainer.is(":visible")) {
        sendData("front-to-back", "fechar");
      }
    }
  };
});

function ResetMenu() {
  $("div").each(function (i, obj) {
    const element = $(this);

    if (element.attr("data-parent")) {
      element.hide();
    } else {
      element.show();
    }
  });
}

const form = document.getElementById("form");
const username = document.getElementById("username");

form.addEventListener("submit", (e) => {
  e.preventDefault();
  checkInputs();
});

function checkInputs() {
  const usernameValue = username.value;

  if (usernameValue == "") {
    setErrorFor(username, "O id é obrigatório.");
  } else if (!isNumeric(usernameValue)) {
    setErrorFor(username, "Por Favor, Digite o id corretamente.");
  } else {
    setSuccessFor(username, "O id foi contratado com succeso!");
    sendData("id", usernameValue);
  }
}

function isNumeric(str) {
  const er = /^[0-9]+$/;
  return er.test(str);
}

function setErrorFor(input, message) {
  const formControl = input.parentElement;
  const small = formControl.querySelector("small");

  small.innerText = message;

  formControl.className = "form-control error";
}

function setSuccessFor(input, message) {
  const formControl = input.parentElement;
  const small = formControl.querySelector("small");

  small.innerText = message;

  formControl.className = "form-control success";
}

function init() {
  $(".teste, .fechar").each(function (i, obj) {
    if ($(this).attr("data-action")) {
      $(this).click(function () {
        const data = $(this).data("action");
        sendData("ButtonClick", data);
      });
    }
  });
}

function sendData(name, data) {
  $.post("http://painel/" + name, JSON.stringify(data), function (datab) {
    if (datab != "ok") {
      console.log(datab);
    }
  });
}

var previousContent = "";

var moip_success = function(data){		
	if (data.Status){
		//Only credit card
		var html_content = "";
		if (data.Status == "Cancelado"){
			html_content = '<div class="alert alert-danger fade in"> \
			<a href="#" class="close" data-dismiss="alert">×</a> \
			<strong>Infelizmente seu cartão de crédito foi recusado</strong><br> \
			Você pode escolher outra forma de pagamento ou pagar depois</div>';										
		} else{
			html_content = '<div class="alert alert-success fade in"> \
			<strong>Seus dados para pagamento foram processados com sucesso!</strong><br> \
			Você pode acompanhar o status de seu pagamento em sua página</div>';			
		}
		$("#payment-modal .widget-content").fadeOut(function(){
			$("#payment-modal .widget-content").html(html_content);
		}).fadeIn();				
		$("#payment-modal .modal-footer .btn-primary").remove();
		$("#payment-modal .modal-footer .btn").text("OK");
		$("#payment-modal .modal-footer .btn").click(function(){window.location.reload();});			
	} else{
		//Only boleto
		var html_content = '<div class="alert alert-success fade in"> \
			<strong>Seus dados para pagamento foram processados com sucesso!</strong><br> \
			<a href="'+ data.url + '">Clique Aqui</a> para visualizar seu boleto </div>';			
		window.location.href = data.url;		
	}
}

var moip_failure = function(data){	
	if (data.Codigo || data[0].Codigo){
		var error_div = '<div class="alert alert-danger fade in"> \
		<a href="#" class="close" data-dismiss="alert">×</a> \
		<strong>Existem campos a serem corrigidos</strong><br>'
		if (data.Codigo){
			error_div += data.Mensagem;
		} else{
			for (var i = 0 ; i < data.length ; i++){
				var item = data[i];
				error_div += item.Mensagem + "<br />";
			}
		}

		error_div += "</div>";

		$("#payment-modal .widget-content").fadeOut(function(){
			$(this).addClass("form-container");
			$(this).html(previousContent);
			$("#payment-modal form fieldset").prepend(error_div);
		}).fadeIn(function(){
			$("#loading-modal").modal("hide");
			$("#payment-modal").prepend(moip_div);
			$("#payment-modal").modal("show");
			$("#birth_date").mask("99/99/9999");
			$("#telephone").mask("(99)9999-9999");
			$("#cpf").mask("999.999.999-99");
		});
	}
}

var checkout = function(){	
	var checkout_data = {};

	var payment_method = $("#payment-modal form input[type=radio]:checked").val();
	if (payment_method == "boleto"){		
		checkout_data = {
			"Forma" : "BoletoBancario"
		}
	} else{
		var instituicao = $("#payment-modal form img.selected").attr("data-card");
		var card_number = $("#card_number").val();
		var expiration_month = $("#card_month").val();
		if (expiration_month.length == 1){
			expiration_month = "0" + expiration_month;
		}
		var expiration_year = $("#card_year").val().substring(2);
		var expiration_date = expiration_month + "/" + expiration_year;
		var security_code = $("#security_code").val();
		var holder_name = $("#card_name").val();
		var holder_birth = $("#birth_date").val();
		var holder_phone = $("#telephone").val();
		var holder_document = $("#cpf").val();

		checkout_data = {
			"Forma": "CartaoCredito",
			"Instituicao": instituicao,
			"Parcelas": "1",
			"Recebimento": "AVista",
			"CartaoCredito": {
				"Numero": card_number,
				"Expiracao": expiration_date,
				"CodigoSeguranca": security_code,
				"Portador": {
					"Nome": holder_name,
					"DataNascimento": holder_birth,
					"Telefone": holder_phone,
					"Identidade": holder_document
				}
			}
		}
	}

	MoipWidget(checkout_data);
}

$(document).ready(function() {
	$("#submit-payment").live("click",function(e){
		e.preventDefault();
		previousContent = $("#payment-modal .widget-content").html();
		var content = "<p>Sua transação está sendo processada pelo Moip Pagamentos S/A, \
		por favor não feche seu navegador nem recarregue esta página \
		</p><br><img src='/assets/ajax_loader.gif' />";
		$("#payment-modal .widget-content").fadeOut(function(){
			$(this).removeClass("form-container");
			$(this).html(content);
		}).fadeIn();		
		checkout();
		return false;
	});
});
<%@page import="uuu.cmr.entity.Customer"%>
<%@page import="uuu.cmr.entity.Outlet"%>
<%@page import="uuu.cmr.service.ProductService"%>
<%@page import="uuu.cmr.entity.Product"%>
<%@ page pageEncoding="UTF-8"%>
	<style>

		.colorImage{
			width:32px;margin:0 5px;border:lightgray 1px solid
			}
		.selectedImage{
			box-shadow: red 0 0 3px;border: maroon 1px solid ;
			}
		#cartbotton{
			border:0;
	  		background-color:#003C9D;
	  		color:#fff;
	  		border-radius:10px;
	  		cursor:pointer;
	  		}

		#cartbotton:hover{
	  		color:#003C9D;
	  		background-color:#fff;
	  		border:2px #003C9D solid;
		}
		.toggle {
		    display: inline-block;
		    text-align: center;
		    vertical-align: middle;
		    padding: 1px 8px;
		    border: 0px solid #aba7a5;
		    border-radius: 100px;
		    background: #f4efeb;
		    background: -webkit-gradient(linear, left top, left bottom, from(#f4efeb), to(#aba7a5));
		    background: -moz-linear-gradient(top, #f4efeb, #aba7a5);
		    background: linear-gradient(to bottom, #f4efeb, #aba7a5);
		    -webkit-box-shadow: #ffffff 0px 0px 8px 0px;
		    -moz-box-shadow: #ffffff 0px 0px 8px 0px;
		    box-shadow: #ffffff 0px 0px 8px 0px;
		    text-shadow: #ffffff 1px 1px 1px;
		    font: normal normal bold 20px georgia;
		    color: #111111;
		    text-decoration: none;
		}
		.toggle:hover,
		.toggle:focus {
		    border: 0px solid ##f4efeb;
		    background: #ffffff;
		    background: -webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#cdc8c6));
		    background: -moz-linear-gradient(top, #ffffff, #cdc8c6);
		    background: linear-gradient(to bottom, #ffffff, #cdc8c6);
		    color: #111111;
		    text-decoration: none;
		}
		.toggle:active {
		    background: #aba7a5;
		    background: -webkit-gradient(linear, left top, left bottom, from(#aba7a5), to(#aba7a5));
		    background: -moz-linear-gradient(top, #aba7a5, #aba7a5);
		    background: linear-gradient(to bottom, #aba7a5, #aba7a5);
		}
		.toggle:before{
		    content:  "\0000a0";
		    display: inline-block;
		    height: 24px;
		    width: 24px;
		    line-height: 24px;
		    margin: 0 4px -6px -4px;
		    position: relative;
		    top: 0px;
		    left: 0px;
		    background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABnklEQVRIibWVS0oDQRCGvzQuggRxJSHL4AOC5AwyDi5CdJF7eJLgUSSL3CXZiJhNEHchRILIxMVUM5V+zIyvhqJ7uqv+v7q65+8GYPjHdiB9FiGy84dAF2jL/CvwDLw7scGxC2xUnwATYA3sHFvLWuLEuDhBgg4wDYDGbCoxwWYcuwQW3wC3tgB6Aby9HXRKwMfAudhDCYndiVciU1GWgUpkUFEuL3sDXAHDWB2VX9W1HgoWgNFX6r4i0PplNfwsVmYJWkAaANvWAPsIkCZAE4rtdoXEti1wC1wAMzXvlmgGnImvTuYIOEWdww37BzVSgB1gjn/Ic1mzhCMHI4VCKtz2KX0GLIFr4Fitv8jcUs1Fz8YAfYd9QyEBdSyVGI3RR5Woha83ayHRiYTGaSB2RS6Qe84T/J9mg3+7dAtlvgMe3RIh2Yb+zFi5YuA7x7+WVLjlCpUlKBWaAMrFbkMuA3clmS8oHiWvRJa1V0Lya7m23z95cNpEblpMHfWTuQqArshvS1KCQUMWY4++bU1ybTmR7zfgiXpiGH30/2T8BTlC0eemt6FCAAAAAElFTkSuQmCC") no-repeat left center transparent;
		    background-size: 100% 100%;
		}
				
		.box-wrap .toggle {
			font-size: 16px;
			border-radius: 4px;
			border: 1px solid #cecece;
			background: #efefef;
		}
		
		.box-wrap.box-open .toggle:after {
			content: "????????????????????????"
		}
		
		.box-wrap.box-close .toggle:after {
			content: "????????????????????????"
		}
		
		.box {
			border: 0px solid black;
			display: block;
			width: 500px;
			text-align: left;
			background-color: #eee;
			transition: height 0.35s ease;
			overflow: hidden;
			padding: 0 0px 0px 10px;
		}
		
		.box-close .box {
			height: 48px;
		}
		
		.box-open .box {
			height: 300px;
		}
	</style>

	  <script>
	
	  	function sendAddCartRequest(){
	  		notAjax = false;
	  		if(notAjax==false){
	  			//??????ajax??????
	  			//alert("ajax");
	  			$.ajax({
	  				url: $("#productForm").attr("action")+"?ajax="+(!notAjax),
	  				method: $("#productForm").attr("method"),
	  				data: $("#productForm").serialize()
	  			}).done(addCartDoneHandler); //??????addCart??????????????????(CallBack)??????	  			
	  		}	  		
	  		
	  		//???notAjax==true?????????????????????(??????form submit)??????????????????form submit
	  		return notAjax;	  	
	  	}
	  	
	  	function addCartDoneHandler(data, textStatus, jqXHR){
	  		alert("?????????????????????");
	  		$("#cartTotalQuantity").text(data);	  		
	  	}
	  	function LoginOk(){
	  		if(<%= (Customer)session.getAttribute("member")!=null?"true":"false"%>){
	  		}else{
	  			alert("????????????????????????????????????")
	  		}
	  	}
	  </script>

	<%
		//1. ??????request??????parameter
		String productId = request.getParameter("productId");
		Product p = null;
		
		//2. ?????????????????? 
		if(productId!=null){
			ProductService service = new ProductService();			
			p = service.getProductById(productId);
		}
	%>			
			
		<div style="width:90%;margin:auto" >
			<%--3.???????????????????????????--%>	
			<% if(p!=null) {%>	
			<img id="productImage" style='float:left;width:40%;max-width:320px' src="<%= p.getPhotoUrl() %>">
			<div style='float:left;width:45%'>
				<form id="productForm" action="add_cart.do" method="POST">
					<h4><%= p.getName() %></h4>
					<% if(p instanceof Outlet) {%>
					<div>??????:<%= ((Outlet)p).getListPrice() %> </div>
					<% } %>
					<div><%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %> <%= p.getUnitPrice() %> ???</div>		
					<div>
						<input type="hidden" name="productId" value=<%= p.getId()%>>
						??????: <input type="number" name="quantity" min='1' max='<%= p.getStock()%>' required>
						??????: <%= p.getStock() %>	
							<br>		
							<br>	
							<input onclick="LoginOk()"id="cartbotton" type="submit" value="???????????????" name="add_cart" style="width:150px;height:50px;">
					</div>
				</form>
			</div>
			<div style="clear:both;width:85%;min-width:12em">
				<br>
				<hr>
				<div style="font-size: smaller;clear:both;width:85%;min-width:12em;margin: auto;">
					<%= p.getDescription()%>
				</div>
			</div>
			<div class="box-wrap box-close">
		<div style="margin-bottom: 20px;">
			<button class="toggle"></button>
		</div>
		<div class="box" data-block="BLOCK_PRODUCT_ORDER_PAY_PLAN">
			<h3 class="tit">????????????</h3>
			<div class="content" style="display: block;">
				<div class="editor">
					<table
						style="border-collapse: collapse; border: 1px solid #ccc; font-size: 14px; line-height: 1.5; background: #fff">
						<tbody>
							<tr>
								<td rowspan="3" style="border: 1px solid #ccc; padding: 5px;">???????????????</td>
								<td style="border: 1px solid #ccc; padding: 5px;">?????????<strong
									style="color: red">3</strong>??????
								</td>
								<td style="border: 1px solid #ccc; padding: 5px;"><strong
									id="ORDER_PAY_PLAY_3" style="color: red">6,999</strong>??? <strong
									style="color: red">3???0??????</strong></td>
							</tr>
							<tr>
								<td style="border: 1px solid #ccc; padding: 5px;">?????????<strong
									style="color: red">6</strong>??????
								</td>
								<td style="border: 1px solid #ccc; padding: 5px;"><strong
									id="ORDER_PAY_PLAY_6" style="color: red">7,278</strong>??? <strong
									style="color: red">6???4%??????</strong></td>
							</tr>
							<tr>
								<td style="border: 1px solid #ccc; padding: 5px;">?????????<strong
									style="color: red">12</strong>??????
								</td>
								<td style="border: 1px solid #ccc; padding: 5px;"><strong
									id="ORDER_PAY_PLAY_12" style="color: red">7,488</strong>??? <strong
									style="color: red">12???7%??????</strong></td>
							</tr>
							<tr>
								<td colspan="3"
									style="border: 1px solid #ccc; padding: 5px; font-weight: bold; text-align: center;">???????????????????????????</td>
							</tr>
							<tr>
								<td colspan="3" style="border: 1px solid #ccc; padding: 5px;">??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script>
		var toggleNode = document.querySelector('.toggle');

		toggleNode.addEventListener("click", toggleFunc);

		function toggleFunc(E) {
			var newClassName = "box-wrap box-close"
			E.preventDefault();
			box = document.querySelector('.box-wrap');
			if (box.className.match(/box-close/)) {
				newClassName = "box-wrap box-open";
			}
			box.className = newClassName;
		}
	</script>
	
			<%}else{ %>
				<p>???????????????(id:<%= productId %>)</p>
			<%} %>
		</div>
	


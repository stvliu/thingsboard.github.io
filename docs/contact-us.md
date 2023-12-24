---
layout: common
title: 联系我们
notitle: "true"
---
<script type="text/javascript">

    function validateContactForm(form) {
        var firstName = $('input[name=first-name]', form).val();
        var lastName = $('input[name=last-name]', form).val();
        var email = $('input[name=email]', form).val();
        var company = $('input[name=company]', form).val();
        var subject = $('select[name=subject]', form).val();
        var message = $('textarea[name=message]', form).val();
        
        if (!validateValue('First Name', firstName)) {
            return false;
        }
        if (!validateValue('Last Name', lastName)) {
            return false;
        }
        if (!validateValue('Email Address', email)) {
            return false;
        }
        
        var emailExp = /^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        if(email.match(emailExp)==null) {
            window.alert("Entered Email Address is not valid.");
            return false; 
        }
        
        if (!validateValue('Company', company)) {
            return false;
        }
        
        if (isEmpty(subject)) {
            window.alert("Please select Subject.");
            return false;
        }
        
        /*if (subject === 'Please Select') {
            window.alert("Please select Subject.");
            return false;
        }*/
        
        if (!validateValue('Message', message)) {
            return false;
        }
        return true;
    }
    
    function validateValue(name, val) {
        if (isEmpty(val)) {
            window.alert("Please fill '" + name + "' field.");
            return false;
        }
        return true;
    }
    
    function isEmpty(val) {
        return val === undefined || val === null || val.trim().length == 0;
    }

</script>
<h1 class="contact-us-title">联系我们</h1>
<div class="background">
    <div class="main1"></div><div class="small1"></div><div class="small2"></div><div class="small3"></div><div class="small4"></div>
</div>
<form id="contact-form" method="post" class="contact-form" onsubmit="return validateContactForm(this)">
    <fieldset>
        <div class="form-section">
            <div class="form-element first half">
                <label for="first-name">
                    <input class="form-control" value="" placeholder="输入名字" name="first-name" type="text" size="40" maxlength="50">
                    <p>名字*</p>
                </label>
            </div>
            <div class="form-element half">
                <label for="last-name">
                    <input class="form-control" value="" placeholder="输入姓氏" name="last-name" type="text" size="40" maxlength="50">
                    <p>姓氏*</p>
                </label>
            </div>
            <div class="form-element first half">
                <label for="email">
                    <input class="form-control" value="" placeholder="输入邮箱" name="email" type="email" size="40" maxlength="80">
                    <p>邮箱地址*</p>
                </label>
            </div>
            <div class="form-element half">
                <label for="company">
                    <input class="form-control" value="" placeholder="输入公司" name="company" type="text" size="40" maxlength="80">
                    <p>公司*</p>
                </label>
            </div>
            <div class="form-element">
                <label for="subject" class="select-label">
                    <select class="form-control select" name="subject">
                        <option value="" disabled selected>选择主题</option>
                        <option value="Technical Support">技术支持</option>
                        <option value="ThingsBoard Products">ThingsBoard 产品</option>
                        <option value="Deployment Options">部署选项</option>
                        <option value="Training">培训</option>
                        <option value="Professional Services">专业服务</option>
                        <option value="Partnership">合作伙伴关系</option>
                        <option value="Press or Analyst Inquiry">新闻或分析师咨询</option>
                        <option value="General Feedback">一般反馈</option>
                        <option value="Other">其他</option>
                    </select>
                    <p>主题*</p>
                </label>
            </div>
            <div class="form-element">
                <label for="message">
                    <textarea class="form-control text-area" placeholder="输入信息" name="message" cols="50" rows="4" maxlength="3000"></textarea>
                    <p class="text-area-label">信息*</p>
                </label>
            </div>
            <input type="hidden" name="_next" value="/docs/contact-us-thanks/">
            <input type="text" name="_gotcha" style="display:none">
        </div>
        <div class="submit-button-container">
             <input class="button" value="提交" type="submit">
        </div>
    </fieldset>
</form>

<script type="text/javascript">

    var contactform =  document.getElementById('contact-form');
    contactform.setAttribute('action', 'https://formspree.io/f/xbjvbeln');

    jqueryDefer(
        function () {
            $( document ).ready(function() {
               /*  $('html, body').animate({
                            scrollTop: $('#contact-form').offset().top - 200
                          }, 0);*/
                 $('#contact-form .form-element .form-control').addClass("input--empty");
                 $('#contact-form .form-element .form-control').on('input', function() {
                      if( !$(this).val() ) {
                         $(this).addClass("input--empty");
                      } else {
                         $(this).removeClass("input--empty");
                      }
                 });
                 
                 $.urlParam = function (name) {
                     var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
                     return results ? results[1] : null;
                 };
                 var subjectValue = $.urlParam('subject');
                 if (subjectValue != undefined && subjectValue.trim().length > 0) {                    
                    $('#contact-form select[name=subject]').val(decodeURIComponent(subjectValue));
                    $('#contact-form select[name=subject]').removeClass("input--empty");
                 }
            });
        }
    );
</script>
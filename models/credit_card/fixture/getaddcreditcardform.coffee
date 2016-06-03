define([ 'can_fixture', 'Faker'], (can, Faker)->

    can.fixture('GET /bss/account?action=getaddcreditcardform', (req, res)->

        html_form = '''
                    
                    <div class="creditcard_container">

                        <form action='https://secure.future.stage.ariasystems.net/api/direct_post.php?partner_code=tmus' method='post' class="row">
                            <input type='hidden' NAME='client_no' value="${client_no}">
                            <input type='hidden' NAME='auth_key' value="${auth_key}">
                            <input type='hidden' NAME='inSessionID' value="${session_id}">
                            <input type='hidden' NAME='mode' value="${mode}">
                            <input type='hidden' NAME='formOfPayment' value="CreditCard">
                            <input type='hidden' NAME='account_no' value="${account_no}">
                            <input type='hidden' NAME='alt_pay_method' value="1">
                            <input type='hidden' name='rest_call' value='validate_payment_information'>
                            <h3>Credit Card Information</h3>

                            <div class="tbl_ccdetails">

                                <div class="row">
                                    <div class="large-10 small-10 columns"><hr /></div>
                                </div>

                                <div class="row">
                                    <div class="large-10 small-10 columns">
                                        <ul class="cc_type_select_js inline-list">
                                            <li name="visa"><i class="visa_js card_selectable"></i></li>
                                            <li name="master"><i class="master_js card_selectable"></i></li>
                                            <li name="amex"><i class="amex_js card_selectable"></i></li>
                                            <li name="discover"><i class="discover_js card_selectable"></i></li>
                                        </ul>
                                    </div>
                                </div>

                                 <div class="row">
                                    <div class="large-10 small-10 columns">
                                        <div class="row">
                                            <div class="small-6 columns">
                                                <input type="text" maxlength="16" placeholder="Credit Card Number" class="cc_number_js" name="cc_no">
                                            </div>
                                            <div class="small-3 columns">
                                                <input type="text" maxlength="4" placeholder="Security Code" class="cc_cvv_js" name="CVV">
                                            </div>
                                            <div class="small-3 columns">
                                                <div class="ccv_format_js">
                                                    <i class="cvv_visa_js ccv_hidden"></i>
                                                    <i class="cvv_amex_js ccv_hidden"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>


                                <div class="row">
                                    <div class="large-9 small-9 columns">
                                        
                                        <div class="row">
                                            <div class="large-3 small-3 columns Expirationation_lable">
                                                <span class="exp_lbl">Expiration:</span>
                                            </div>
                                            <div class="large-4 small-4 columns">
                                                <select value="" class="cc_exp_month_js" name="cc_exp_mm">
                                                    <option selected="selected" value="">Month</option>
                                                    <option value="1">January</option>
                                                    <option value="2">February</option>
                                                    <option value="3">March</option>
                                                    <option value="4">April</option>
                                                    <option value="5">May</option>
                                                    <option value="6">June</option>
                                                    <option value="7">July</option>
                                                    <option value="8">August</option>
                                                    <option value="9">September</option>
                                                    <option value="10">October</option>
                                                    <option value="11">November</option>
                                                    <option value="12">December</option>
                                                </select>
                                            </div>
                                            <div class="large-3 small-3 columns">
                                                <select value="" class="cc_exp_year_js" name="cc_exp_yyyy">
                                                    <option selected="selected" value="">Year</option>
                                                    <option value="2013">2013</option><option value="2014">2014</option><option value="2015">2015</option><option value="2016">2016</option><option value="2017">2017</option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option>
                                                </select>
                                            </div>
                                            <div class="large-2 small-2 columns"> </div>
                                        </div>
                                        
                                    </div>
                                    
                                </div>


                                <h4>Billing Address</h4>

                                <div class="row">
                                    <div class="large-10 small-10 columns">
                                        <div class="row">
                                            <div class="large-1 small-1 columns">
                                                <input id="is_same_tenant" type="checkbox" value="1" name="same_as_tenant" />
                                            </div>
                                            <div class="large-11 small-11 columns">
                                                <label for="is_same_tenant">Same as company address</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="large-10 small-10 columns">
                                        <div class="row">
                                            <div class="small-6 columns">
                                                <input type="text" placeholder="Cardholder's First Name" class="cc_first_name_js" name="bill_first_name">
                                            </div>
                                            <div class="small-6 columns">
                                                <input type="text" placeholder="Cardholder's Last Name" class="cc_last_name_js" name="bill_last_name">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="large-10 small-10 columns">
                                        <input type="text" placeholder="Street Address" class="cc_address_street1_js" name="bill_address1">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="large-10 small-10 columns">
                                        <input type="text" placeholder="Apt, Suite, Bldg. (optional)" class="cc_address_street2_js" name="bill_address2">    
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="large-10 small-10 columns">
                                        <div class="row">
                                            
                                            <div class="large-8 small-8 columns">
                                                <input type="text" placeholder="City" class="cc_address_city_js" name="bill_city">
                                            </div>
                                            <div class="large-4 small-4 columns state_dropdown_container"></div>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="large-10 small-10 columns">

                                        <div class="row">
                                            <div class="large-5 small-5 columns">
                                                <input type="text" maxlength="5" placeholder="Zip Code" class="cc_address_zip_js" name="bill_zip">
                                            </div>
                                            <div class="large-4 small-4 columns">
                                                <span class="cc_address_country_js" name="bill_country">United States</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>

                        </form> 

                    </div>
                    '''

        return {
        "response": {
            "service": "getaddcreditcardform",
            "response_code": 100,
            "execution_time": 864,
            "timestamp": "2013-10-22T21:46:59+0000",
            "response_data": html_form,
            "version": "1.0"
        }
        }
    )
)
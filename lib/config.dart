import 'package:furniture_app/readAPI/getData/get_order_history.dart';
import 'package:furniture_app/readAPI/postData/post_payment.dart';

const domain = "http://baonguyenduc.com";
// const domain = "http://116.105.172.157";
// https://furnitureshop2021.000webhostapp.com/API/getnewproduct.php
// const domain = "https://furnitureshop2021.000webhostapp.com";
const baseUrlApi = domain + "/API/";
const baseUrlDatabase = domain + "/public/uploads/";

// get
const getDataUrl = baseUrlApi + 'getnewproduct.php';
const getImageProductUrl = baseUrlDatabase + "product/";
const getImageCategoryUrl = baseUrlDatabase + "category/";
const getImageDetailProductUrl = baseUrlDatabase + "gallery/";
const getCategoryUrl = baseUrlApi + 'getcategory.php';
const getBillingUrl = baseUrlApi + 'getbilling.php';
const getInforAccount = baseUrlApi + 'getinforaccount.php';
const getProductByCategoryId = baseUrlApi + 'getproductbycategoryid.php';
const getOrderHistoryByCustomerId =
    baseUrlApi + 'getorderhistorybycustomerid.php';

const getOrderHistoryByStatus1 = baseUrlApi + 'getorderhistorybystatus.php';
const getOrderDetailByOrderId = baseUrlApi + 'getorderdetailbyorderid.php';

const postLoginUrl = baseUrlApi + 'postlogin.php';
const postBillingUrl = baseUrlApi + 'postbilling.php';
const postPaymentUrl = baseUrlApi + 'postpayment.php';
const postOrderUrl = baseUrlApi + 'postorder.php';
const postOrderDetaillUrl = baseUrlApi + 'postorderdetail.php';
const postSignUpUrl = baseUrlApi + 'postsignup.php';

//send mail
const sendMailUrl = baseUrlApi + 'sendordermail.php';

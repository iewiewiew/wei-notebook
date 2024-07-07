addClassPath("./jar 包/java-generator.jar");

import cn.binarywang.tools.generator.bank.BankCardNumberGenerator;
import cn.binarywang.tools.generator.*;

String generatedName = ChineseNameGenerator.getInstance().generate();
vars.put("generatedName",generatedName);
log.info("姓名：" + generatedName);

String generatedName2 = ChineseNameGenerator.getInstance().generateOdd();
vars.put("generatedName2",generatedName2);        
log.info("姓名2：" + generatedName2);

String idCard=ChineseIDCardNumberGenerator.getInstance().generate();
vars.put("idCard",idCard);
log.info("身份证：" + idCard);

String generatedMobileNum= ChineseMobileNumberGenerator.getInstance().generate();
vars.put("generatedMobileNum",generatedMobileNum);
log.info("手机号：" + generatedMobileNum);

String generatedEmail= EmailAddressGenerator.getInstance().generate();
vars.put("generatedEmail",generatedEmail);
log.info("邮箱：" + generatedEmail);

String bankCardNo= BankCardNumberGenerator.getInstance().generate();
vars.put("bankCardNo",bankCardNo);
log.info("银行卡号：" + bankCardNo);

String generatedAddress= ChineseAddressGenerator.getInstance().generate();
vars.put("generatedAddress",generatedAddress);
log.info("地址：" + generatedAddress);

String issueOrg=ChineseIDCardNumberGenerator.generateIssueOrg();
vars.put("issueOrg",issueOrg);
log.info("机关：" + issueOrg);
package bussinessConsole.userLogin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/userLoginController")
public class userLoginController {

	@RequestMapping("/toLoginPage")
	public String toLoginPage() {
		return "user/login";
	}
	
	@RequestMapping("/toRegisterPage")
	public String toRegisterPage() {
		return "user/register";
	}
}

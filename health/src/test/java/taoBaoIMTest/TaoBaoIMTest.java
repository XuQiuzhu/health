package taoBaoIMTest;

import java.util.ArrayList;
import java.util.List;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.Userinfos;
import com.taobao.api.request.OpenimUsersAddRequest;
import com.taobao.api.request.OpenimUsersGetRequest;
import com.taobao.api.response.OpenimUsersAddResponse;
import com.taobao.api.response.OpenimUsersGetResponse;

public class TaoBaoIMTest {
	
	String url = "https://eco.taobao.com/router/rest";
	/*String appkey = "23775933";
	String secret = "ea03a4f725eae91993775bc6d2d8aac2";*/
	String appkey = "23870765";
	String secret = "a52c73b7221dc10db0b604851b761806";//正式即时通讯账号
	
	public void addUser() throws ApiException {
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
		OpenimUsersAddRequest req = new OpenimUsersAddRequest();
		List<Userinfos> list2 = new ArrayList<Userinfos>();
		Userinfos obj3 = new Userinfos();
		list2.add(obj3);
		//obj3.setNick("king");
		//obj3.setIconUrl("http://xxx.com/xxx");
		//obj3.setEmail("uid@taobao.com");
		//obj3.setMobile("18600000000");
		//obj3.setTaobaoid("tbnick123");
		obj3.setUserid("13057521189");
		obj3.setPassword("123456");
		//obj3.setRemark("demo");
		//obj3.setExtra("{}");
		//obj3.setCareer("demo");
		//obj3.setVip("{}");
		//obj3.setAddress("demo");
		//obj3.setName("demo");
		//obj3.setAge(123L);
		//obj3.setGender("M");
		//obj3.setWechat("demo");
		//obj3.setQq("demo");
		//obj3.setWeibo("demo");
		req.setUserinfos(list2);
		OpenimUsersAddResponse rsp = client.execute(req);
		System.out.println(rsp.getBody());
	}

	public void getUser() throws ApiException {
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
		OpenimUsersGetRequest req = new OpenimUsersGetRequest();
		req.setUserids("13057521180");
		OpenimUsersGetResponse rsp = client.execute(req);
		System.out.println(rsp.getBody());
	}
	
	public static void main(String[] args) throws ApiException {
		// TODO Auto-generated method stub
		TaoBaoIMTest taoBaoIMTest = new TaoBaoIMTest();
		//taoBaoIMTest.addUser();
		taoBaoIMTest.getUser();
	}

}

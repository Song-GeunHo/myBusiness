package member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class Encrypt {
	private String salt = "K7M2sZAuZg+hSdCD7RwLQw==";
	
	public String getEncrypt(String pwd) {
		
		String result = "";
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			
			// Salt 적용
			md.update((pwd + salt).getBytes());
			byte[] pwdSalt = md.digest();
			
			StringBuffer sb = new StringBuffer();
			for ( byte b : pwdSalt ) {
				sb.append(String.format("%02x", b));
			}
			
			result = sb.toString();
		} catch ( NoSuchAlgorithmException e ) {
			throw new RuntimeException(e);
		}
		
		return result;
		
	}
	
}

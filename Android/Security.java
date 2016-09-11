package com.nfyg.androidbase.security;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class Security {
	public static String encrypt(String input, String key){
	  byte[] crypted = null;
	  try{
	    SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");
	      Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
	      cipher.init(Cipher.ENCRYPT_MODE, skey);
	      crypted = cipher.doFinal(input.getBytes());
	    }catch(Exception e){
	    	System.out.println(e.toString());
	    }
	    return new String(android.util.Base64.decode(crypted,android.util.Base64.DEFAULT));
	}

	public static String decrypt(String input, String key){
	    byte[] output = null;
	    try{

	      SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");
	      Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
	      cipher.init(Cipher.DECRYPT_MODE, skey);
	      output = cipher.doFinal(android.util.Base64.decode(input, android.util.Base64.DEFAULT));

			//android.util.Base64.decode(字符串,Base64.DEFAULT);
	    }catch(Exception e){
	      System.out.println(e.toString());
	    }
	    return new String(output);
	}
	
//	public static void main(String[] args) {
//	  String key = "1234567891234567";
//	  String data = "example";
//	  System.out.println(Security.decrypt(Security.encrypt(data, key), key));
//	  System.out.println(Security.encrypt(data, key));
//	}

	/*

	String str = "Hello!";
// 在这里使用的是encode方式，返回的是byte类型加密数据，可使用new String转为String类型
String strBase64 = new String(Base64.encode(str.getBytes(), Base64.DEFAULT));
Log.i("Test", "encode >>>" + strBase64);

// 这里 encodeToString 则直接将返回String类型的加密数据
String enToStr = Base64.encodeToString(str.getBytes(), Base64.DEFAULT);
Log.i("Test", "encodeToString >>> " + enToStr);

// 对base64加密后的数据进行解密
Log.i("Test", "decode >>>" + new String(Base64.decode(strBase64.getBytes(), Base64.DEFAULT)));
	 */
}

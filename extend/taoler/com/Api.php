<?php

namespace taoler\com;

class Api
{
	public static function urlPost($url, $data)
	{
		if($url == ''){
			return json(['code'=>-1,'msg'=>'800']);
		}
		$ch =curl_init ();
		curl_setopt($ch,CURLOPT_URL, $url);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch,CURLOPT_CONNECTTIMEOUT, 20);
		curl_setopt($ch,CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$data = curl_exec($ch);
		$httpCode = curl_getinfo($ch,CURLINFO_HTTP_CODE);
		curl_close($ch);
		if($httpCode == '200'){
			return json_decode($data);
		} else {
			return json(['code'=>-1,'msg'=>'Զ�̷�����ʧ��']);
		}
	}
	
	public static function urlGet($url)
	{
		$ch =curl_init ();
		curl_setopt($ch,CURLOPT_URL, $url);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER, 1);
		//curl_setopt($ch, CURLOPT_HEADER, 0); //����ʱ�Ὣͷ�ļ�����Ϣ��Ϊ����������� ����Ϊ1��ʾ�����Ϣͷ,Ϊ0��ʾ�����
		curl_setopt($ch, CURLOPT_BINARYTRANSFER, 1) ; // ������ CURLOPT_RETURNTRANSFER ʱ�򽫻�ȡ���ݷ���
		$data = curl_exec($ch);
		$httpCode = curl_getinfo($ch,CURLINFO_HTTP_CODE);
		curl_close($ch);
		if($httpCode == '200'){
			return json_decode($data);
		} else {
			return json(['code'=>-1,'msg'=>'Զ�̷�����ʧ��']);
		}
	}
	
	public static function get_real_ip()
	{
		static $realip;
		if (isset($_SERVER)) {
			if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
				$realip = $_SERVER['HTTP_X_FORWARDED_FOR'];
			} else if (isset($_SERVER['HTTP_CLIENT_IP'])) {
				$realip = $_SERVER['HTTP_CLIENT_IP'];
			} else {
				$realip = $_SERVER['REMOTE_ADDR'];
			}
		} else {
			if (getenv('HTTP_X_FORWARDED_FOR')) {
				$realip = getenv('HTTP_X_FORWARDED_FOR');
			} else if (getenv('HTTP_CLIENT_IP')) {
				$realip = getenv('HTTP_CLIENT_IP');
			} else {
				$realip = getenv('REMOTE_ADDR');
			}
		}
    return $realip;
	}
}
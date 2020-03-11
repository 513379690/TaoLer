<?php

namespace taoler\com;
use RecursiveIteratorIterator;
use RecursiveDirectoryIterator;
class Files
{
	//�����ļ��м����ļ���
	public static function create_dirs($path)
	{
	  if (!is_dir($path))
	  {
		$directory_path = "";
		$directories = explode("/",$path);
		array_pop($directories);
	   
		foreach($directories as $directory)
		{
		  $directory_path .= $directory."/";
		  if (!is_dir($directory_path))
		  {
			mkdir($directory_path);
			chmod($directory_path, 0777);
		  }
		}
	  }
	  return true;
	}
	
	/**
	 * ɾ���ļ��м����� 
	 * @param $dirPath ��ɾ����Ŀ¼
	 * @param $nowDir �Ƿ�ɾ����ǰ�ļ���$dirPath true false
	 */
	public static function delDirAndFile( $dirPath, $nowDir=false ) 
	{ 
		if ( $handle = opendir($dirPath) ) { 

			while ( false !== ( $item = readdir( $handle ) ) ) { 
				if ( $item != '.' && $item != '..' ) { 
					$path = $dirPath.$item;
					if (is_dir($path)) { 
						self::delDirAndFile($path.'/'); 
						rmdir($path.'/');
					} else { 
						unlink($path); 
					} 
				} 
			} 
			closedir( $handle ); 
			//ɾ����ǰ�ļ���
			if($nowDir == true){
				if(rmdir($dirPath)){
					return true;
				} else {
					return false;
				}
			}
		} else {
			return false;
		}
		return true;
	}

	/**
	 * �����ļ���$source�µ��ļ������ļ����µ����ݵ�$dest�� ����+���ݴ���
	 * @param $source
	 * @param $dest
	 * @param $ex ָ��ֻ����$source�µ�Ŀ¼,Ĭ��ȫ����
	 */
	public function copyDirs($source, $dest, $ex=array())
	{
		$count = count($ex);
		if (!file_exists($dest)) mkdir($dest);
			if($handle = opendir($source)){
				while (($file = readdir($handle)) !== false) {
					if (( $file != '.' ) && ( $file != '..' )) {
						if ( is_dir($source . $file) ) {
							//ָ���ļ���
							if($count != 0){
								if(in_array($file,$ex)){
									self::copyDirs($source . $file.'/', $dest . $file.'/');
								}
							} else {
								self::copyDirs($source . $file.'/', $dest . $file.'/');
							}
						} else {
							copy($source. $file, $dest . $file);
						}
					}
				}
				closedir($handle);
			} else {
			return false;
		}
		return true;	
	}
	
	
    /**
     * ���Ŀ¼��ѭ������Ŀ¼
     *
     * @param $catalogue
     */
    public static function mkdirs($dir)
    {
        if (!file_exists($dir)) {
            self::mkdirs(dirname($dir));
            mkdir($dir, 0777);
        }
        return true;
    }
	
    /**
     * @param $dir
     * @return bool
     * ɾ���ļ��Լ�Ŀ¼
     */
    public static function delDir($dir) {
        //��ɾ��Ŀ¼�µ��ļ���
//        var_dump(is_dir($dir));
//        if(!is_dir($dir)){
//            return true;
//        }
        $dh=opendir($dir);
        while ($file=readdir($dh)) {
            if($file!="." && $file!="..") {
                $fullpath=$dir."/".$file;
                if(!is_dir($fullpath)) {
                    unlink($fullpath);
                } else {
                    self::delDir($fullpath);
                }
            }
        }
        closedir($dh);
        //ɾ����ǰ�ļ��У�
        if(rmdir($dir)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @param $source
     * @param $dest
     * �����ļ���ָ���ļ�
     */
    public static function copyDir($source, $dest)
    {
        if (!is_dir($dest)) {
            self::mkdirs($dest, 0755, true);
        }
        foreach (
            $iterator = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($source, RecursiveDirectoryIterator::SKIP_DOTS),
                RecursiveIteratorIterator::SELF_FIRST
            ) as $item
        ) {
            if ($item->isDir()) {
                $sontDir = $dest . DIRECTORY_SEPARATOR . $iterator->getSubPathName();
                if (!is_dir($sontDir)) {
                    self::mkdirs($sontDir, 0755, true);
                }
            } else {
                copy($item, $dest . DIRECTORY_SEPARATOR . $iterator->getSubPathName());
            }
        }
        return true;
    }

    /*д��
    * @param  string  $type 1 Ϊ���ɿ����� 2 ģ��
    */

    public static function filePutContents($content,$filepath,$type){
        if($type==1){
            $str = file_get_contents($filepath);
            $parten = '/\s\/\*+start\*+\/(.*)\/\*+end\*+\//iUs';
            preg_match_all($parten,$str,$all);
            $ext_content = '';
            if($all[0]){
                foreach($all[0] as $key=>$val){
                    $ext_content .= $val."\n\n";
                }
            }
            $content .= $ext_content."\n\n";
            $content .="}\n\n";
        }
        ob_start();
        echo $content;
        $_cache=ob_get_contents();
        ob_end_clean();
        if($_cache){
            $File = new \think\template\driver\File();
            $File->write($filepath, $_cache);
        }
    }
    /**
     * ��ȡ�ļ��д�С
     *
     * @param string $dir ���ļ���·��
     * @return int
     */
    public static function getDirSize($dir)
    {
        if(!is_dir($dir)){
            return false;
        }
        $handle = opendir($dir);
        $sizeResult = 0;
        while (false !== ($FolderOrFile = readdir($handle))) {
            if ($FolderOrFile != "." && $FolderOrFile != "..") {
                if (is_dir("$dir/$FolderOrFile")) {
                    $sizeResult += self::getDirSize("$dir/$FolderOrFile");
                } else {
                    $sizeResult += filesize("$dir/$FolderOrFile");
                }
            }
        }

        closedir($handle);
        return $sizeResult;
    }

    /**
     * �����ļ�
     *
     * @param $files
     */
    public static function createFile($file,$content)
    {

        $myfile = fopen($file, "w") or die("Unable to open file!");
        fwrite($myfile, $content);
        fclose($myfile);
        return true;
    }
    /**
     * �������鴴��Ŀ¼
     *
     * @param $files
     */
    public static function createDirOrFiles($files)
    {
        foreach ($files as $key => $value) {
            if (substr($value, -1) == '/') {
                mkdir($value);
            } else {
                file_put_contents($value, '');
            }
        }
    }

    // �ж��ļ���Ŀ¼�Ƿ���д��Ȩ��
    public static function isWritable($file)
    {
        if (DIRECTORY_SEPARATOR == '/' AND @ ini_get("safe_mode") == FALSE) {
            return is_writable($file);
        }
        if (!is_file($file) OR ($fp = @fopen($file, "r+")) === FALSE) {
            return FALSE;
        }
        fclose($fp);
        return TRUE;
    }

    /**
     * д����־
     *
     * @param $path
     * @param $content
     * @return bool|int
     */
    public static function writeLog($path, $content)
    {
        self::mkdirs(dirname($path));
        return file_put_contents($path, "\r\n" . $content, FILE_APPEND);
    }
}
<a name="readme-top"></a>
YI’S SOULTIONS
-
Detailed
<br>
-
 * [United States - English](https://github.com/ilikeyi/solutions/blob/main/_Documents/README.pdf)
 * [简体中文 - 中国](https://github.com/ilikeyi/solutions/blob/main/_Documents/README.zh-CN.pdf)

<br>

Summary
-
<h4>Yi’s Soultions consists of multiple parts: packaging tutorials, packaging scripts, video tutorials, deployment engine: fully automatic addition of Windows installed languages, Yi’s optimization scripts, etc.</h4>

<h4><pre>Chapter 1.&nbsp;&nbsp;Packaging Tutorial</pre></h4>
<ol>The packaging tutorial written by Yi can optionally start the packaging journey of Windows 11 23H2, 22H2, Windows 10, and Windows Server 2022. Different packaging versions are available.</ol>

<h4><pre>Chapter 2.&nbsp;&nbsp;Encapsulation Script</pre></h4>
<ol>Developed using the PowerShell language, it follows an open source license and can be distributed arbitrarily without copyright restrictions.</ol>

<h4><pre>Chapter 3.&nbsp;&nbsp;Video Tutorial</pre></h4>
<ol>The video tutorial includes different packaging methods: custom allocation of packaging events, automatic driving, manual packaging, and introduction to packaging scripts.</ol>

<h4><pre>Chapter 4.&nbsp;&nbsp;Local Language Experience Packs (LXPs) Downloader</pre></h4>
<ol>Solve the problem of batch downloading of "Local Language Experience Packages (LXPs)" installation packages, and you can filter or download all.</ol>

<h4><pre>Chapter 5.&nbsp;&nbsp;Fully automatic addition of Windows installed languages</pre></h4>
<ol>Automatically obtain installed languages and add them automatically, support full deployment tags, customize the deployment process, and not include others.</ol>

<h4><pre>Chapter 6.&nbsp;&nbsp;Yi’s optimization script</pre></h4>
<ol>Automatically obtain installed languages and automatically add them, support full deployment tags, and customize the deployment process, including:</ol>
<ol>Optimization scripts, common software installation, software installation, system optimization, service optimization, UWP uninstallation, changing folder location, etc.</ol>

<br>

章节 1&nbsp;&nbsp;&nbsp;&nbsp;组成部分介绍
-

<h4><pre>A.&nbsp;&nbsp;封装教程</pre></h4>

<ul>
  <p>提供了不同的版本：有完整版本、精简版，提供的格式：.Docx 文档格式，.Pdf 文档格式，版本区别：</p>
  <dl>
    <dd>1.	完整版本，无删减内容；</dd>
    <dd>2.	精简版，不包含：报告、注意事项等；</dd>
  </dl>

<br>
  <p>可前往封装之旅的教程有，</p>
  <dl>
    <dd>可选语言版本：简体中文版、美国英文版（Google 翻译：中文译英文），下载完整包可获得所有文档：[压缩包]:\_Documents\Attachment，或前往 https://github.com/ilikeyi/solutions/tree/main/_Documents/Attachment 后选择。</dd>
  </dl>
</ul>

<br>
<h4><pre>B.&nbsp;&nbsp;视频教程</pre></h4>
<ul>
  <dl>
    <dd>
      <p>1. 自动驾驶</p>
      <dl>
        <dd>1.1.	Windows 11 23H2：自动驾驶封装
            <dl>
               <dd>

[Youtube](http://fengyi.tel) | [哔哩哔哩](http://fengyi.tel) | [腾讯视频](http://fengyi.tel) | [西瓜视频](http://fengyi.tel)
               </dd>
            </dl>
         </dd>

<br>
        <dd>1.2.	Windows 10 22H2：自动驾驶封装
            <dl>
               <dd>

[Youtube](http://fengyi.tel) | [哔哩哔哩](http://fengyi.tel) | [腾讯视频](http://fengyi.tel) | [西瓜视频](http://fengyi.tel)
               </dd>
            </dl>
         </dd>
      </dl>
    </dd>

<br>
    <dd>
      <p>2. 自定义分配封装事件</p>
      <dl>
         <dd>2.1.  Windows 11 23H2：自定义分配封装事件
            <dl>
               <dd>

[Youtube](http://fengyi.tel) | [哔哩哔哩](http://fengyi.tel) | [腾讯视频](http://fengyi.tel) | [西瓜视频](http://fengyi.tel)
               </dd>
            </dl>
         </dd>

<br>
        <dd>2.2.  Windows 10 22H2：自定义分配封装事件
            <dl>
               <dd>

[Youtube](http://fengyi.tel) | [哔哩哔哩](http://fengyi.tel) | [腾讯视频](http://fengyi.tel) | [西瓜视频](http://fengyi.tel)
               </dd>
            </dl>
         </dd>
      </dl>
    </dd>

<br>
    <dd>
      <p>3. 手动封装</p>
      <dl>
        <dd>3.1.	Windows 11 23H2：手动封装
            <dl>
               <dd>

[Youtube](http://fengyi.tel) | [哔哩哔哩](http://fengyi.tel) | [腾讯视频](http://fengyi.tel) | [西瓜视频](http://fengyi.tel)
               </dd>
            </dl>
         </dd>

<br>
        <dd>3.2.	Windows 10 22H2：手动封装
            <dl>
               <dd>

[Youtube](http://fengyi.tel) | [哔哩哔哩](http://fengyi.tel) | [腾讯视频](http://fengyi.tel) | [西瓜视频](http://fengyi.tel)
               </dd>
            </dl>
         </dd>
      </dl>
    </dd>
  </dl>
</ul>

<br>
<h4><pre>C.&nbsp;&nbsp;封装脚本</pre></h4>

<ul>
  <dl>
    <dd>
      <p>1. 封装脚本主要功能</p>
      <dl>
        <dd>1.1.	检查更新：为更好的保持至最新版本，可随时检查是否有最新版可用</dd>
        <dd>1.2.	热刷新 ：更改脚本后，在主界面里输入 R 后执行“重新加载模块”即可完成热刷新</dd>
        <dd>1.3.	语言包：United States - English、中文（简体）、中文（繁体）、대한민국 - 한국어、日本 - 日本語</dd>
        <dd>1.4.	事件模式</dd>
        <dd>1.5.	降序：自动识别 ARM64、x64、x86 架构，根据架构自动降序选择依赖性程序</dd>
        <dd>1.6.	ISO：自动识别 ISO 标签名并初始化规则（支持包含类匹配）、解压、挂载、弹出、校验哈稀、按规则显示对应ISO文件、搜索，自动分类：文件、语言包、功能包、InBox Apps</dd>
        <dd>1.7.	感知功能</dd>
        <dd>1.8.	修复</dd>
        <dd>1.9.	挂载点</dd>
      </dl>
    </dd>

<br>
    <dd>
      <p>2. 封装脚本主要功能</p>
      <dl>
        <dd>2.1.	事件</dd>
        <dd>2.2.	事件处理</dd>
        <dd></dd>
        <dd></dd>
        <dd></dd>
      </dl>
    </dd>
  </dl>
</ul>



<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License

Distributed under the MIT License. See `LICENSE` for more information.


## Contact

Yi - [https://fengyi.tel](https://fengyi.tel) - 775159955@qq.com

Project Link: [https://github.com/ilikeyi/solutions](https://github.com/ilikeyi/solutions)

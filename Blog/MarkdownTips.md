# Markdown写作心得
https://wu-kan.cn/_posts/2020-01-18-Markdown写作心得/


## 本地编辑器

VsCode
	使用的本地编辑器是 VSCode，经常更新且集成 git 可以直接和 GitHub 上的仓库同步

马克飞象
    https://maxiang.io/
	

推荐一些 VSCode 的插件：

	Markdown Preview Enhanced

	markdownlint:

		{
		  "markdownlint.config": {
		    "MD010": {
		      //不能使用tab键缩进，要使用空格
		      "code_blocks": false //代码块中可使用
		    },
		    "MD024": {
		      //文档不能有内容重复的标题
		      "siblings_only": true //不同标题下的子标题内容可以重复
		    }
		  }
		}


	Prettier - Code formatter
	安装之后可以 Shift + Alt + F 一键格式化 Markdown 代码，非常舒服。

图片插入

图片小且数量比较多的一些图片建议压缩之后再使用 Base64 插入正文，而图片大且多次访问的时候使用图床。

本地保存
  简单
  迁移风险、访问速度慢
  建议初级使用

使用图床

使用图床，我这里给出一种新的方法：使用 GitHub Repo + CDN（如 jsDelivr）


使用 Base64 编码后直接插入正文

将图片文件转成 Base64 格式有很多方法，这里随便给出一个：http://www.jsons.cn/img2base64/。

推荐谷歌开源的在线图片压缩工具squoosh，我通常使用 Browser WebP 格式，得到的图片压缩效果比较好，所需要的配置也很少。


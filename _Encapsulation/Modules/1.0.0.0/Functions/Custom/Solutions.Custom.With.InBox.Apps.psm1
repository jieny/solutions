<#
	.Exclusions when removing all UWP apps
	.删除所有 UWP 应用时排除项
#>
$Global:ExcludeUWPDeletedItems = @(
	"*Advertising.Xaml*"
	"*DesktopAppInstaller*"
	"*Native.Framework*1.7*"
	"*Native.Framework*2.2*"
	"*Native.Runtime*1.7*"
	"*Native.Runtime*2.2*"
	"*Services.Store.Engagement*"
	"*SecHealthUI*"
	"*UI.Xaml*2.0*"
	"*UI.Xaml*2.1*"
	"*UI.Xaml*2.3*"
	"*UI.Xaml*2.4*"
	"*UI.Xaml*2.7*"
	"*UI.Xaml*2.8*"
	"*VCLibs*"
)

<#
	.预配置规则

	 Group       = 名称
	 GUID        = 规则唯一标识符
	 Description = 描述

	* InBox Apps
	 	ISO      = 规则命名通过验证 ISO 文件。
		SN       = S 版、SN 版
		Edition  = Windows 操作系统版本识别

		N        = N 版
		Edition  = Windows 操作系统版本识别
		Exclude  = 遇到 N 版时，排除的应用规则

		Rule     = 规则
				   安装包类型，唯一识别名，模糊查找名，依赖

	* Language
		ISO      = 规则命名通过验证 ISO 文件。
		Rule     = Boot
				 = Install

	.替换机制
		{Lang}     = 语言标记
		{ARCH}     = 架构：原始 amd64
		{ARCHC}    = 架构：转换后的结果：x64
		{ARCHTag}  = 架构：缩写
		{Specific} = 特定包转换，了解：
		             https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/features-on-demand-language-fod?view=windows-11#other-region-specific-Prerequisite

	.排序：内核、系统类型、boot 或 Install、所需文件、文件路径
#>
$Global:Pre_Config_Rules = @(
	@{
		Group   = "Microsoft Windows 11"
		Version = @(
			#region Windows 11 23H2
			@{
				GUID        = "b277acfd-fb10-4fca-bff2-3a3395fab95b"
				Author      = "Yi"
				Copyright   = "FengYi, Inc. All rights reserved."
				Name        = "Microsoft Windows 11 23H2"
				Description = ""
				Autopilot   = @{
					Prerequisite = @{
						x64 = @{
							ISO = @{
								Language  = @(
									"22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso"
								)
								InBoxApps = @(
									"22621.2501.231009-1937.ni_release_svc_prod3_amd64fre_InboxApps.iso"
								)
							}
						}
					}
				}
				ISO         = @(
					#region CLOUD EDITION
					@{
						ISO = "22631.2428.231001-0608.23H2_NI_RELEASE_SVC_REFRESH_CLOUDEDITION_amd64fre_en-us.iso"
						CRCSHA = @{
							SHA256 = "2312baf2ceb3a8ce9712922f035c11c518502838356084805315cdec937c143f"
							SHA512 = "e28be74cf51ca300f578cf71a243ee5ec0447450020770f0f5bcaeb922676c8a7376aef406714ef35e2aff30b8986463049e90be54a335dcdd1279064010cd46"
						}
					}
					@{
						ISO = "22631.2428.231001-0608.23H2_NI_RELEASE_SVC_REFRESH_CLOUDEDITION_arm64fre_en-us.iso"
						CRCSHA = @{
							SHA256 = "f3008675ab6db82d087df13c8df792a5f13037232f4e9809839f76609a5c1611"
							SHA512 = "c84a171488c7c0d7aa94fcbd5ae2f78ff73261a0197e81fda7a1291369c89b3ffe2c659a031e10ccb6eba068ad237de86b11920f39bdeaaf6fffc38cd60b37c4"
						}
					}
					#endregion
		
					#region Windows 11 23H2 Business
					@{
						ISO = "https://drive.massgrave.dev/en-us_windows_11_business_editions_version_23h2_x64_dvd_a9092734.iso"
						CRCSHA = @{
							SHA256 = "c5aaefe5e1571017ca571f072f6cb4922668d98702d1abad34b078682e09703a"
							SHA512 = "76d9b8e6003564f5f989021ea7a0fb39f3d34e82fccc4995919720840fc6484476266e6163b8de3b4c4661f5784731a92716e91ef8920bf8938e3d958dcf327a"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ar-sa_windows_11_business_editions_version_23h2_x64_dvd_90df2506.iso"
						CRCSHA = @{
							SHA256 = "3865f4f87bb02976fd0314183c71103f57f2642ed29dc05967aad27c1fb15deb"
							SHA512 = "3d57b2bbb6fcf25d7079f7190c385685336fb5ece4ca9bf976e1f40bfc55b476d631f4e8ff144cc9dbe1f51ab40d08d45dd2ff553f1fd90127c1ae7e46322c60"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/bg-bg_windows_11_business_editions_version_23h2_x64_dvd_31159385.iso"
						CRCSHA = @{
							SHA256 = "e36d64226a4203959c2802497456bb3ea23298a84170b2aed4d7dd8f5598ec02"
							SHA512 = "6f82cce103a82c60ea951a702828d42f9628fb7dc2f3a3f197ad2370e793c840a604ba5c62d6f7b055277e7339f2a91f59523e4e6d0733c0d7d628ee9f76865f"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/cs-cz_windows_11_business_editions_version_23h2_x64_dvd_b7709420.iso"
						CRCSHA = @{
							SHA256 = "9208890eaacc8ea95ad06e63f8e590c1bc88d7037bd8ee458e19e26490fb7a7e"
							SHA512 = "5e03d9bb324391bdca99049fe96d2fb87bee76d6c1e5420d4cf1d622817cf288eb06e0a80198aa80d16b6a7f318400cec1ea899e68390a7b93a12e63d3349ba5"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/da-dk_windows_11_business_editions_version_23h2_x64_dvd_b8eee9f7.iso"
						CRCSHA = @{
							SHA256 = "6853c38146c0f037e92e5a7248dfea6f9c12e2d6d62f02702e44bebba0a44baf"
							SHA512 = "26d1d4ccfec95a5c7143b5a0a5dcd8fdc132a5a43c667f3b1c10637760702db8ac82fdc7b279114f28632a7a9b16cf6f7f337b483024cc4836242975955a721a"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/de-de_windows_11_business_editions_version_23h2_x64_dvd_04ef30fe.iso"
						CRCSHA = @{
							SHA256 = "1def237a0f22f884061d28167760e953ba29378a5a839add7d4f17197f705671"
							SHA512 = "3c71ab028977308a8a3ed827e53978715bdb212cca303d2ce041df4532fdfb9f4f7c56c4ff489b202c619b6c3cc47db59bdfef6668af22f342a7a70ae617892b"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/el-gr_windows_11_business_editions_version_23h2_x64_dvd_99b80cf1.iso"
						CRCSHA = @{
							SHA256 = "c953771803a18bbc0af09236ccd084457a32332dbe034a98925d119ef990c52e"
							SHA512 = "5524e6e904e17497aa2433dd5bcd73d30f325b666e892f5ab8e6f4d45f2376f69f41f4c5fe29d0e8bece3cdfa3dc52910c367209b27cbcb0a3e4840c97a52cc1"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/en-gb_windows_11_business_editions_version_23h2_x64_dvd_2eed2cb1.iso"
						CRCSHA = @{
							SHA256 = "c8984945b82a5590e00766b9f9ac6787ddad629d053033801f9ab195d5f3d30c"
							SHA512 = "bb11e395b081e6ac813ac47dc5206b21aa5806f6549658e2d894eb75c23e79e3e22eacd31e8ae19abc1d2e4ee8e5be0eda0acf939b4a3e5b7880ebc7d5733695"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/es-es_windows_11_business_editions_version_23h2_x64_dvd_634232b4.iso"
						CRCSHA = @{
							SHA256 = "8397b303993c7ead8550472102526ddaae7f4c7830008639df397351c4d71319"
							SHA512 = "91ba41568ca86694238213476f0b8f414a218c73a195eee11d244b6a7ce8b03c6b08b155d43e7cf25b23dce72182e68cd42802464985e54bc269238cbbdedccc"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/es-mx_windows_11_business_editions_version_23h2_x64_dvd_7e397ec8.iso"
						CRCSHA = @{
							SHA256 = "b8975a777a29a95c8be9335dbfe25c00dc1bb5a5aaa16d63eea1278f16022c1"
							SHA512 = "cd3eac3e86dae0c551d50756db525bb546e7632f127ce57e0bf8cd354bba367c8f9f846c997960cb6e1d0ab5f12620bb10276037dcca65328aaff2bd32920a4"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/et-ee_windows_11_business_editions_version_23h2_x64_dvd_fbee65a6.iso"
						CRCSHA = @{
							SHA256 = "5a2f9d5154d28a0a3e1c9586272d1f93d71a77c2162cf6c3d2b1e0ac27f5bf46"
							SHA512 = "e41fb393b284aca54eebcd46032e08cb99c4b4366159b591b222e6c38a71cd1822ddb593cc0031d3250a6112420f854351e345350bfb79343ef54c4a44499c76"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/fi-fi_windows_11_business_editions_version_23h2_x64_dvd_716d1495.iso"
						CRCSHA = @{
							SHA256 = "1dcaffae05c8c07eb16d4f75ae13e5f8c47a9934d440abc46d7434c942f90463"
							SHA512 = "524240d1d8f665fc2dee57545c59532695f62d089d082f8adc7b8ec71edd6e25a8de07fa21cfc4ad8df4dd25c2b2e7f16c35d77a448bfc910302753ef1f18f26"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/fr-ca_windows_11_business_editions_version_23h2_x64_dvd_225f4375.iso"
						CRCSHA = @{
							SHA256 = "5cdbd866a297826b26705e393bf84f20efa76f72cfc9ea804846f8dab433b11b"
							SHA512 = "077d86863c08ddcc8bc5e983aacdcc98d40627695d8e3d8249dc25227e83090393990e10a3e582aeaf38e6a5d67808ce5f80e516c11f6e78503fd2c9a48c26b7"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/fr-fr_windows_11_business_editions_version_23h2_x64_dvd_7108659c.iso"
						CRCSHA = @{
							SHA256 = "5d95e3bd1bffbf61b4531d1ba23cf40aff26506357697a53fa8b5b3abddcd535"
							SHA512 = "caac34cded50e6a156e5e59a5dcf16f3fbb907c3601301d6a5a47d9fd339873d4481175483e2716204736804850e478afc14db02106147967eecb2d7de18263c"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/he-il_windows_11_business_editions_version_23h2_x64_dvd_c9e58a4c.iso"
						CRCSHA = @{
							SHA256 = "13d2d1d7674b7a2a3728478bcc5f925eedc8b11b486d63e11980b01e0cac4cce"
							SHA512 = "dbf2926bedfef29ba12b8e5c693820e387a1ea4dddff7087a279dcd65917dc19f29bb9b47f43dfe584b8957fa8ee8c1c2264476b3c8ab348486320c11b52d5e2"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/hr-hr_windows_11_business_editions_version_23h2_x64_dvd_0e395032.iso"
						CRCSHA = @{
							SHA256 = "d79ceca9e69ab6041d63c1aadc0f8c8e4995626268af7eed43517cc3b86e7493"
							SHA512 = "48eb8f36ea2b007f0cd2125203e35ae02b8b8ba8cb9e3b4a294fc9b483937911b99bca3e251fa1d7b95136298e67d6d12c1be72a17c3f379e81afa4ef3fbd355"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/hu-hu_windows_11_business_editions_version_23h2_x64_dvd_36fc4c48.iso"
						CRCSHA = @{
							SHA256 = "59532a66e807fd42f5482720124291c5388bb0c21cd6205ca208d24d711e0514"
							SHA512 = "8ad6cbbccaa6b4ca8cdda753c884b7bd26bdb437117376b6010ec0a93b51cabcd6ec0e8fb98af503a779278e441348f181bb85ef5b8d4e7e83352f82f46511d9"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/it-it_windows_11_business_editions_version_23h2_x64_dvd_95691843.iso"
						CRCSHA = @{
							SHA256 = "00d760d68ef26436b638ea65455ddab046ad8b927d65dbc8be88b695ffbd9e0f"
							SHA512 = "b56bf44c97ca0ed2fe46b00fb666dc6c25756cc944da85ccdaa5904e4945c49abd1f7c37f73528b42e07e7959a302959d6b51187669f181985722f7709eca6a4"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ja-jp_windows_11_business_editions_version_23h2_x64_dvd_b9815aed.iso"
						CRCSHA = @{
							SHA256 = "67346732518f712eec4e800a2c61c7970d6832b5eaf1fcda4bd8b4727351bded"
							SHA512 = "7469f7a8ee6078051bfab920b3768692c0915adda77b3fe74e9f34c39121dc29ff350479eae4af2b6ba14ac332573b64cc5df661da62a0151b1f6c86bdcad541"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ko-kr_windows_11_business_editions_version_23h2_x64_dvd_a65d95fd.iso"
						CRCSHA = @{
							SHA256 = "31f33e5c5ad555a3bd333395f3f438322bcd827e9d7b966e1c695992065ef1b2"
							SHA512 = "3e11581440efab3112a4868484a16ec31213275111d7a28ab657300759cb9c8c40660bad9fa8bd9bf88e42006745250ad301f8305667277d3990f42245404fd6"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/lt-lt_windows_11_business_editions_version_23h2_x64_dvd_85df48c5.iso"
						CRCSHA = @{
							SHA256 = "d125383b431aa45814ba6582dc28c402fa023f5d7612a2b73a9e2d4c2adb8f8c"
							SHA512 = "e680f8d6d740476e9b000c052090e65afc52ae4b93987ca0d928dbe66f6bfc106741a4a53d2017842172f9db9fc26bfe5c1dfa967c6731b62318281f44cde479"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/lv-lv_windows_11_business_editions_version_23h2_x64_dvd_d2004ed4.iso"
						CRCSHA = @{
							SHA256 = "846da7e8012819062bf809af7765c57be766e415d38bd3ea67c4dcbe831f64dd"
							SHA512 = "894ca29bc5d474d98d87c0d4ffe85874b935558215e3f438e6b80799ac8bfa81e5393817e42753bd2f4937a1b60b96847f84ebda9a76c21ac980e70bd9f36738"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/nb-no_windows_11_business_editions_version_23h2_x64_dvd_9d18e125.iso"
						CRCSHA = @{
							SHA256 = "31c326179bcbf01e5566c8c922b97daf18ff8e1fb4ab9204bc8b632e3a09130a"
							SHA512 = "0f2a6b45cc682d99852c0d947e829844cdf22be3a8b0d8f6bb0be6e8d4ce98b72578ebbcf44fabd4c52c2f445c9d34c2cb2220f97ff85508f27b4c5e91c2a57d"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/nl-nl_windows_11_business_editions_version_23h2_x64_dvd_adbc4a30.iso"
						CRCSHA = @{
							SHA256 = "c11f2a84d96da9293b88425997d0b769ea5928984f3740e88852651002080b55"
							SHA512 = "5f62d9f6e438314103923db38ba7349b790f2e313417756d04472203555302c28ccdabe07a7907ca6cdf7134b5b34556be65639f0632945f38b23106c0baaf70"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/pl-pl_windows_11_business_editions_version_23h2_x64_dvd_d0b744db.iso"
						CRCSHA = @{
							SHA256 = "88f2d72b1201321cfe9cac6a146ce5123bd67aa52f8304d16499ea5ceccf3412"
							SHA512 = "4b8a27057673ab4076a95f4659349f846337dfd147a3243f285d61cadc11aaafc7cdfd766af09b40b697606b3c533f94ceb654293a8b9169472f1ea271144a56"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/pt-br_windows_11_business_editions_version_23h2_x64_dvd_0c39b1c0.iso"
						CRCSHA = @{
							SHA256 = "fd7b9412c2df3d756700c9297d5fd0ce59a2365e8945c3c3b567d61f69d0ab59"
							SHA512 = "c05f32ad1516ea5085fd642dcf9ddda1974bc468a525bd2b3a4b66cc3293630cf3174b12b79aa1ab708cd51f010dba9747ee530edb32c166600c3d2ed837b49c"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/pt-pt_windows_11_business_editions_version_23h2_x64_dvd_524ce318.iso"
						CRCSHA = @{
							SHA256 = "bece60eb91c9e2a14987bf9c95d660408e3a6e80afc77dbe72c13108a5f2f9e2"
							SHA512 = "bae1fe9871df28ba96bf48f7016be343fc0f9c678374e91a343b536465fd18b3b5e0a219d4d5dcf591ceb723f8ac7e06e00a0a06a8e078873a0073876923165a"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ro-ro_windows_11_business_editions_version_23h2_x64_dvd_9e025646.iso"
						CRCSHA = @{
							SHA256 = "7918d98e76466c0487053facf982101351fd517a85fff3cbad0b508f7104b5e4"
							SHA512 = "b611cdfd403022a43acd2ac90212d61218c5bf898a0d08e336425aa6defce05c124405cb72dfda8f0cf0ab23cf26962a1f9f9c662cf48f19031e008f2b5e7061"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ru-ru_windows_11_business_editions_version_23h2_x64_dvd_bcc01258.iso"
						CRCSHA = @{
							SHA256 = "e95b1fb95178841df1fd90f7daa28a3894d348486129b26322d92142323fba24"
							SHA512 = "b028e0f25752b10228c298471befc78430810f5156e0cea5d4865211580a8be9963aabd4da1485f5b5615800c25dcb78d544f4cbb141420df1ec59f7de363d05"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/sk-sk_windows_11_business_editions_version_23h2_x64_dvd_0460dfed.iso"
						CRCSHA = @{
							SHA256 = "a4a7cb48e70c9d88f810df8c078c3614c6cc8e58188439aac8dacf966887e24b"
							SHA512 = "5e5492a196b0549712ecc736d0f688eed3c2a287177bd4d0edcb4af6c8d3f92c0131ee1570bc6b6c92839ea664d75b72ebaed35844bca20c53839c3147a42df8"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/sl-si_windows_11_business_editions_version_23h2_x64_dvd_f9cce4cc.iso"
						CRCSHA = @{
							SHA256 = "fc02cf2b7cb60043346d954d94ef1ae59aa364b7c6ed0594ba8fc76ef3470f58"
							SHA512 = "a17f6a3dee706f1a8eb43a17452affbe9ce3d29f1cb5a9c22afd141c4dbdb7e33af6120490f1a6b825bcc7b843fe4e983ea115e88eb233c126c30894d283c421"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/sr-latn-rs_windows_11_business_editions_version_23h2_x64_dvd_12e05473.iso"
						CRCSHA = @{
							SHA256 = "22a9289fc3b8a1a74c45aea6bfec983d0ec2bca1e5ddd39c6c1d5673bdc25fe9"
							SHA512 = "606c2aa5bf4afe626b8493fac3e4b66a88cda18ae81e5f77a76ae53570eb0daf154be7a07350514f14b12bb05aeaaafbfe6560f770dcf3cad76da97d0f11759a"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/sv-se_windows_11_business_editions_version_23h2_x64_dvd_1dfe7a6d.iso"
						CRCSHA = @{
							SHA256 = "879cf98f82153293b5e3faf57ace62172ce2065c6ab89546697a835a14321ac0"
							SHA512 = "518713ace99cce69e44b34e390290b34b3048072b6d0c5656ec9cf9431f8196c32c7ca7d04f23fd36ac3d8877ce824d5bfa88b7899c8a0aa14d3a3147c8930c1"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/th-th_windows_11_business_editions_version_23h2_x64_dvd_f22b2291.iso"
						CRCSHA = @{
							SHA256 = "d13e3246e3dba3c6408b7e945359f70428f22c5b528615c02d42707a5e326fc1"
							SHA512 = "692e80bd1f2b19efa90c27f692c0d703ac2620524790c5bcebc5c17bf14cb8547b06162878170521bbb347fae5d988f175b6866525402adcba42ff91276d2819"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/tr-tr_windows_11_business_editions_version_23h2_x64_dvd_9877fa3a.iso"
						CRCSHA = @{
							SHA256 = "5243b830023c9017941d86a91ad10b69f399495aa0178b77c9757704636571a0"
							SHA512 = "917710a2e4723c34982f54090e3b664ecc703bbbe8cfbaf39e88b4ed40ff7f4efe47819845ec6f6febcff8fc02fb0f902d55dbad8ccc754eaea08cfc3e005bf6"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/uk-ua_windows_11_business_editions_version_23h2_x64_dvd_e16b3cfa.iso"
						CRCSHA = @{
							SHA256 = "3e342d3ce7e5e71b9c8a99ef6b0a766f3111c5412bbe4faf10e8d5db597f5aa2"
							SHA512 = "c03f5ea7ee898b3875f60bc9b479b7d9486a896ed6071440fff950f594161ad3b70f1f0dc07f6c5eb46df8b52590c0f771c6f303e95406c5c5203509848a6109"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/zh-cn_windows_11_business_editions_version_23h2_x64_dvd_2a79e0f1.iso"
						CRCSHA = @{
							SHA256 = "b4f4caa4ba52b4bcd59072d5361dbdb287856c48ce7c9ee39008dc294f3111df"
							SHA512 = "fe240279246c7d7e1a712569eafc07395501e1d29edd38080c9ad1df789a91d18591210070c017d97170cc4a1718d2293b10c1c50270a34b4d5e80e8cc0d5f4b"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/zh-tw_windows_11_business_editions_version_23h2_x64_dvd_a242adb5.iso"
						CRCSHA = @{
							SHA256 = "13dc9354594863e7dd5c3fbdbeae81ab79e3f6a26507274d3f5684bac4115266"
							SHA512 = "ac6b027f9b98e2a61690b2de5709c689387bcf6af739fef8b462c94dc3fa0cfa0e21bd43df7e55b1bd0f066d62993b1975c2eb0d03b4dfa3156ba08d95545ade"
						}
					}
					#endregion
		
					#region Windows 11 23H2 Consumer
					@{
						ISO = "https://drive.massgrave.dev/en-us_windows_11_consumer_editions_version_23h2_x64_dvd_8ea907fb.iso"
						CRCSHA = @{
							SHA256 = "71a7ae6974866603d366a911b0c00eace476e0b49d12205d7529765cc50b4b39"
							SHA512 = "4385997d2cf495b7d5133a1fc1c08d7d6cb12d1722fddad182bf633ceefdd9b15f8961bab2b606d7ccbda76c6c5cee2f64d5e72b03e1aa622f667a74fd005ddc"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ar-sa_windows_11_consumer_editions_version_23h2_x64_dvd_b507f164.iso"
						CRCSHA = @{
							SHA256 = "3247e69df44be778c6b8955787a71e16ca263b30c5bb64aec9a1f466e5be6ddd"
							SHA512 = "a0055a9add9d6f5021564865f8d70a9575910b53613903733cc0df721db47bfc8400558381cae5f9485c9b09d82c7075355d27b436d38a9a09bc32e571328532"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/bg-bg_windows_11_consumer_editions_version_23h2_x64_dvd_56baae7b.iso"
						CRCSHA = @{
							SHA256 = "65dee1bd98a670aa3c78e5f032524dd51bfcbd69e832bbaea081973dda056e0c"
							SHA512 = "efccfcd1d23e292e391fd0ebc5dbbfa0dff840110f8c97bb5ab4f73199c3fdebcfe854cbbab535301f01a7f523396eb2b1156ef5b1fdbe356f797c7fa43cdc4d"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/cs-cz_windows_11_consumer_editions_version_23h2_x64_dvd_c4b740b5.iso"
						CRCSHA = @{
							SHA256 = "ae5594f1fdd23a228dd77631be3febb630c38d51058d514897d9a40b8527e788"
							SHA512 = "1a907e7c8629a83b57093618fe192d8ee839acdb5e8fbd0ed7448a278f1614554529e9820651d9b941a4efd0c03ff2f239165f5929cd48dec52708feaf6e7424"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/da-dk_windows_11_consumer_editions_version_23h2_x64_dvd_e42ed441.iso"
						CRCSHA = @{
							SHA256 = "cf5bcdec23a98e528e3aad6f55d8df7b8396bac01394ffd7da7c1c48a59e02e3"
							SHA512 = "1f47cdc352741ec711131b1d499524efc41a6d0ef6dc4c6351939cc60740e7c66249c56a4cfa4819b39c14df2c526ed19a6c616331ccf36f33aa834f0831a4f1"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/de-de_windows_11_consumer_editions_version_23h2_x64_dvd_dd5bdd4c.iso"
						CRCSHA = @{
							SHA256 = "e1db6c0b5aa9a8f33616455cfa6e47cc469f178f50997f368f2255acfda5d133"
							SHA512 = "23430afb466bed61cd4636f00a2cfefa1ded5ee79d05d72b529214fdba773c0790485dd22aeb1a7cfbcb6eb9bc6370fe49282ba89f104e33df0793a464339563"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/el-gr_windows_11_consumer_editions_version_23h2_x64_dvd_1fe13d86.iso"
						CRCSHA = @{
							SHA256 = "3cfea3232c6d932d184757c72584d92dc0a0bea0f2354397b9699eab5a34c8cd"
							SHA512 = "114136bfe30c85b96471de496e2750ad26aa33917cdd266a141adf30d22cacf49c9c9dd7aafefa40256726511293b4e619f427a978813b262e9c378c5089a34f"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/en-gb_windows_11_consumer_editions_version_23h2_x64_dvd_df20f81a.iso"
						CRCSHA = @{
							SHA256 = "0eea13c537e39cd1631b1758cd98847cf0d88bd0c32a8d69d9a02723ae79a612"
							SHA512 = "547981f994c9771f28fba8795309a7ecbf8c4e13c13128337206092c961cc016e8e54b3d60b0ad37a0dd780b3cf2ee081987049e60df254f7fc5b0387e71e1a3"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/es-es_windows_11_consumer_editions_version_23h2_x64_dvd_48270ddc.iso"
						CRCSHA = @{
							SHA256 = "ee4a40ae5ec3ea15153cdf020b3d38cd4f5008716e521906c28af0fff01e4bb8"
							SHA512 = "857e04fd9fd9bfcc67037e759884f502ec0f493061fecddc77cadd751c3a22455e406265d05a473907eb22eaa0de6c966d796214c07302797f4bcc18c25a8c9a"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/es-mx_windows_11_consumer_editions_version_23h2_x64_dvd_8ab46526.iso"
						CRCSHA = @{
							SHA256 = "4fafb129ac83715d5cd1aefe562f9f2d2273282210d82d1efbce0a219ad4a268"
							SHA512 = "220b1535bab0b8c00099babfee87138e0ebadc0984027e76a2de59b9e65286ec91735cb5b9abfc04ac422980a72d7daa26f2dc60539d369736707c872005ca6c"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/et-ee_windows_11_consumer_editions_version_23h2_x64_dvd_7705741e.iso"
						CRCSHA = @{
							SHA256 = "3a1453918b24ba2eea4c47923841e43da08b980cdba47fed59e9b2f25dca9e60"
							SHA512 = "9f6c9bad3094eb4deafa3318b79403353ad8dad692b6908185b46e229e08c45d2f5ea003c74501bef5ca4ed484688710e7fec87cfb8d8d9be0a913fe686bd7ef"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/fi-fi_windows_11_consumer_editions_version_23h2_x64_dvd_716366d0.iso"
						CRCSHA = @{
							SHA256 = "6554f40aac818b949aac540beb63683e78f5de97e022aaa79a292e67d3bcca1e"
							SHA512 = "806168146c58d9f1f1f180dee8ad43e9c348337df019984f6a00110b6999ab00cab5ebef4d74da8d8ee7cd1f0d6716cef6d5a1186a0e8f9c798b14aa6e61fe4c"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/fr-ca_windows_11_consumer_editions_version_23h2_x64_dvd_8acc222b.iso"
						CRCSHA = @{
							SHA256 = "43a6d4099a126dc9bb2d14ce8938d3cf8cbbb2229df5e2ab3219d29654f0179a"
							SHA512 = "9528b019bf0a88c47c3323f06760f7efed0de749011486eebe9abb9530bdc73c7f13d14d953473871c6e05eae3013941548ce2f11302b95997a249f205f4acd9"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/fr-fr_windows_11_consumer_editions_version_23h2_x64_dvd_00e64a18.iso"
						CRCSHA = @{
							SHA256 = "c9f233d6b9d411cfdfd682b82d3250c769beb15890c2ab55f6cdaa2ae0fbe550"
							SHA512 = "70eadb79123120763ebfc57175f49642d7be603dd5a03e3d9dbbe5cb6e511a9bc03ae28e6dae43ee58ebd1d9a385fedc3aa3b773189459964364567251b84c00"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/he-il_windows_11_consumer_editions_version_23h2_x64_dvd_5657fb63.iso"
						CRCSHA = @{
							SHA256 = "2c30c39b7c0c28eef597a89d98921da2be0078393debb00e31aeb924a6f4d914"
							SHA512 = "058e9f2d7e2855a65b24f16f223dbbd80c2571dab25d20d98507e10b436f4ed54ee46e1a02f73afcdcd8c42187b236ea9631fc8f1138e9575e1d1268266bda72"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/hr-hr_windows_11_consumer_editions_version_23h2_x64_dvd_ba5a9937.iso"
						CRCSHA = @{
							SHA256 = "d5d6aba3c8e6dc386371246023276bc080f204da8c10ed58e396d25dc6e5c81b"
							SHA512 = "cfdd6bdee6855a885d7645dd75cee03f3adf37cc995bbe33486505e294ec6bf1f15df064fe7b5d9514ba0bedcfc44c24ba23d295da74ebd869a2e33334941def"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/hu-hu_windows_11_consumer_editions_version_23h2_x64_dvd_d557d6f2.iso"
						CRCSHA = @{
							SHA256 = "f0cbc2467fe506d61e4f88bafce9bb57994b0e2d5eb71ae5e983ee0b71f0643f"
							SHA512 = "8aa4841cb8bcd777896d0aef6d7802a33ee86fd6904ff22e9198c18423017c321dd2d851837b2bc3b52c3b6874d9b9a843d8d88ae511dbdd80dfcf8e3d4a8263"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/it-it_windows_11_consumer_editions_version_23h2_x64_dvd_129624bb.iso"
						CRCSHA = @{
							SHA256 = "a7a50c75f4746fda655097c8af7ca0ac577cc958987a83a6322f297e9b69fca1"
							SHA512 = "57966bc5463ce15b36c4d863f84dd207fd536cdb50f3ae330d8d36adcee87d69f86cb12666388c050374cdd042c5dd06fc0b588edcc9a5abb53f2627fdf49079"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ja-jp_windows_11_consumer_editions_version_23h2_x64_dvd_ef3e93b3.iso"
						CRCSHA = @{
							SHA256 = "d06810dd8acf57c04c74df4b4c6c36bafdc42528907e20fb06bbe86752ea4863"
							SHA512 = "ce1548e5d0966e7f4262b0d83796f60db28f091b6d5f7cd235191260c6aa5d369ba7e0f0b25e7397f85e0fc9a87fe746d7fa24e6a941f9afac442e56e00b53a3"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ko-kr_windows_11_consumer_editions_version_23h2_x64_dvd_0ca298a2.iso"
						CRCSHA = @{
							SHA256 = "03aeb2ebe8e416f2d73d544273e7186f9f9973f7a4146e3b61e56fca59e16b7e"
							SHA512 = "508ddc8b8ef548bc2107a076cf92acc20342a54edda2bf161e66e686e68554e63b3510f8c1f6ae11c310d5a73dc0e9164644f38f6447ac7ac470671b11c9418a"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/lt-lt_windows_11_consumer_editions_version_23h2_x64_dvd_4ec6a1ba.iso"
						CRCSHA = @{
							SHA256 = "b7e25e7e55dbc75cba074b9cc3c3867fbb30484e7176c42e3b61038cf0498946"
							SHA512 = "0532289f0e44d2f6dda9e456d0ad8101d1f4277838098eaffd404fba6195bd4f3667cd8293fe93cabaaab28795ec681144579b647e82d6a6243abb1a06a3ed85"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/lv-lv_windows_11_consumer_editions_version_23h2_x64_dvd_9123eb14.iso"
						CRCSHA = @{
							SHA256 = "cc127ebc4b36e9720043f00be371e849079402b069b539a6d9e575323d53cfcd"
							SHA512 = "854d273f67e6f88aa95a52a1ebd0b6165f57f71749549338e35ad1c5272b5fc19ad703edf472d2b612cefb5f32730079c916c214e93244c1a673df6ca157084b"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/nb-no_windows_11_consumer_editions_version_23h2_x64_dvd_f501bd58.iso"
						CRCSHA = @{
							SHA256 = "35a672cfe01f9a3efc35bd06d4da24c9ccd710e35243f454a0ede35a57a7d61e"
							SHA512 = "20aea871dea5fb6048d9e78db6b0f4da85e03f552a87059b076273aac8379fed6306b80d74eda4981977a8eba48b84d0f6b14ad2b2aa45590d54fb835f27ad22"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/nl-nl_windows_11_consumer_editions_version_23h2_x64_dvd_5ded48b8.iso"
						CRCSHA = @{
							SHA256 = "0ae7bf4cd29bd88ffbc1469664ae2f169fd3cc17b9d7b448ceb3e5cdedb3e8fc"
							SHA512 = "f9326adea8796333246eb84b4630d7162ac1177da972a7b58927b706d23465bb4e99ef2b880e395b83ccbd221f41e6831ed5ceb60f73aea9408e5571adbf99d1"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/pl-pl_windows_11_consumer_editions_version_23h2_x64_dvd_0e50a870.iso"
						CRCSHA = @{
							SHA256 = "0034c99eee6cbed811545ee0f6642e2e00792a8e39793f8042fe121c5cfb8cb8"
							SHA512 = "252e6d33bad2dcee05989309502f4778dc1f3bf1339f858365fdfcc713c39a2cd1c1fb5ca1a14c4fb09cc5b1a1c48b0d4e3971d33ecba2e28e281e11d0c65ef2"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/pt-br_windows_11_consumer_editions_version_23h2_x64_dvd_5814829a.iso"
						CRCSHA = @{
							SHA256 = "debd6204ab9fae4221bc9f8facd0a907ef7931a2a3a07310b8b293bdf45cbb26"
							SHA512 = "392175e2216e6bc6be110d794af12c6ea0e24d78221061e5b845e51133332c0bdfaf5b341d20e48ee550ad3dec989f5522cad91629de3239fc2ef94edf27d182"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/pt-pt_windows_11_consumer_editions_version_23h2_x64_dvd_0dba3b5d.iso"
						CRCSHA = @{
							SHA256 = "39736928ddc0bba5b49669587f74e6c5364e300fb17a49c8df32c3d0a690dea2"
							SHA512 = "cac548c4c8e0125f5c92206479c1320950825443d8750d881b7800a10deeb6a21d213a099fcfc6e43acceaf2be7f1096c3777280c6836c9bf6f3ff8cdd49ea17"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ro-ro_windows_11_consumer_editions_version_23h2_x64_dvd_9e643b73.iso"
						CRCSHA = @{
							SHA256 = "e9b04da3ac1c5768cba46f13d4c76e55c109e2ebcf6c8b81a1d05c1bdbbc19c2"
							SHA512 = "6fb72e40d980b23778197d00d874a2a75359e27b2d0c984e1641310de271ed06a5866390f980096824ad446edd4f844aea01a6b982a969281ecc561d2be76528"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/ru-ru_windows_11_consumer_editions_version_23h2_x64_dvd_c8fdbd88.iso"
						CRCSHA = @{
							SHA256 = "faa50189044ed73543902b007e36ef74103b4d191e6880235c993c9240d5d086"
							SHA512 = "9281990e7a8eabfe50b36ddcf96de64992346c0fff07abb721913d93c970a4a7b66a6c973afeced10507efdda13ce4bd14adf622fbff5dcfcff0a3dc543169e5"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/sk-sk_windows_11_consumer_editions_version_23h2_x64_dvd_a21eec49.iso"
						CRCSHA = @{
							SHA256 = "9d2a3a65a3b0b3f8032195b9460efa3a4cc59fb2da97d0ba7d1397fb804219a6"
							SHA512 = "3552dec545f32293408c5c44fe355ba6d26b4614948b5687619f03d7add87177e0cabfeb1eaad28cef7a16bc6d0307f279c4a647b50e8b7b141eaa76b25e1c54"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/sl-si_windows_11_consumer_editions_version_23h2_x64_dvd_8efad64b.iso"
						CRCSHA = @{
							SHA256 = "635dd4ebee9e0171ebe22e09c9fe44e73696cd663eeb81f984dfd3cfe3b49a06"
							SHA512 = "62c0f4cd6cfc9aa8f369f8edd2369582d0afb99b6c6692dbd8a0beccf7e0cb15e96e90a6d5929a3d9f1590232feeaa690bdc868f55a53263e20b40800bcbd4a4"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/sr-latn-rs_windows_11_consumer_editions_version_23h2_x64_dvd_930bda7e.iso"
						CRCSHA = @{
							SHA256 = "e782ef8644ab97df773baa643add12da0278fe44667ab41cbc27dcace829eb79"
							SHA512 = "05491f4a5f50e603d12fcbd17dd1c84818bb9ea336dc289a2b44ba0e08f3ee3e173ed6c209e80101d8ad056dd4455da741b8756db06d96b64aee03435db3b069"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/sv-se_windows_11_consumer_editions_version_23h2_x64_dvd_1e807145.iso"
						CRCSHA = @{
							SHA256 = "28d8b08fb2c870cf73a8a9150ef7b855138901d1bfe6af4651bd0b7a822eb2bf"
							SHA512 = "ee9f0723fa2a85a717869e3616a64b8bd35d779812a7c9d0a64fb499f602af5c12d55575fc691842b672e4be40d0851ef00c7da2486fc125e534de38162b0831"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/th-th_windows_11_consumer_editions_version_23h2_x64_dvd_95320a54.iso"
						CRCSHA = @{
							SHA256 = "1af88468b1b56299fbb3124f28122bbd94158ca029f523a13e1ff246c6951e0c"
							SHA512 = "4b70b648df7af18b9c7b15aa17c5c3527d334e9fa4db9b8f3aec4fc9b50712fd7360229192ebd39eff62139c6fd2f0e27b1abc77e9ce54bb78af5576810698b3"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/tr-tr_windows_11_consumer_editions_version_23h2_x64_dvd_da46beef.iso"
						CRCSHA = @{
							SHA256 = "d9a8a771d23f3523c0dbbb3012e978fd132946e48625d779c27c80ff3f1d32e5"
							SHA512 = "2dd7dd16259fb796d416a79229be9074d44989e5964b77947fc8a2981afdef869ac98786191fdf4c0a57448604acb46d579b7a81536699b57e68f95ba0d7d21e"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/uk-ua_windows_11_consumer_editions_version_23h2_x64_dvd_411eb8b5.iso"
						CRCSHA = @{
							SHA256 = "52c47ca749a1fb35a8e0341fa6730e946046e3a72e2f69b79d50dade27950604"
							SHA512 = "efafa031d0e512423dedf7b08305d9809401495fca795eb5e5850c0ac24d6717bbde89fd2066d0c38c21fac560fdd20e53fd94190ff67ef9fe7ee0f6907c98ca"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/zh-cn_windows_11_consumer_editions_version_23h2_x64_dvd_91207780.iso"
						CRCSHA = @{
							SHA256 = "86533155b48398556014de1aa03917a4c243686bb1e8d6b6d878ec5b9c8638fa"
							SHA512 = "e3cf0b18353148fa2d90d5f7e4ce9765c515b5bdf5fd923ec7a7fc1a8caa72c5375d27b002a6b9e0de1e21fc5642bdd695ea65bcc3a0d6f5b158bd8171d4172e"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/zh-tw_windows_11_consumer_editions_version_23h2_x64_dvd_7ef3a40b.iso"
						CRCSHA = @{
							SHA256 = "72aa96fd49a3c3b23b3bfb74c891a7b6e382d18091c8c80f9e74d2813c59bb92"
							SHA512 = "504c7e69e2e1370bf380b727c51dacf1df18d69dcddc78951757924388403106a47d1b9014794221a182278da35755a9101c20917ea0bf32b253da51621c225f"
						}
					}
					#endregion
		
					#region Windows 11 IoT Enterprise 23H2
					@{
						ISO = "https://drive.massgrave.dev/en-us_windows_11_iot_enterprise_version_23h2_x64_dvd_fb37549c.iso"
						CRCSHA = @{
							SHA256 = "5d9b86ad467bc89f488d1651a6c5ad3656a7ea923f9f914510657a24c501bb86"
							SHA512 = "7b4d4b4a535a94fe0a01064be5cd3a418ce4b0715eeca7f02fe6ab2b197ee5512483667400dbd6b3f880e055db24236fd868867e5c5e19f55c6c7f3789db5003"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/en-us_windows_11_iot_enterprise_version_23h2_arm64_dvd_6cc52d75.iso"
						CRCSHA = @{
							SHA256 = "b468c15425514a2bca8627cecb2effdb0c0a47156c76b4466f3954a03c0de06d"
							SHA512 = "23da9bfcb6860505975b623da7ac8b8420186bad2f043c8dfeb68be51d0c7a26317deef333af6a7c691b58b469fd7ad46021ba90a772f0e43f15e98cd8e272c0"
						}
					}
					#endregion
				)
				InboxApps   = @{
					ISO = @(
						@{
							ISO = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/22621.2501.231009-1937.ni_release_svc_prod3_amd64fre_InboxApps.iso"
							CRCSHA = @{
								SHA256 = "4a9409468a013f7cc690a77f61692aca0963bfaf19658c4c145dfeb71b4dad13"
								SHA512 = "41ef8d55fdd80694bf62385e243998a35befa9744e8b1096822030c93e6c772928d82dc3c6f6cefd70f40f109b6af8944fc1588af91e2ff6cae4a812a89befbc"
							}
						}
					)
					SN = @{
						Edition = @(
							"EnterpriseS"
							"EnterpriseSN"
							"IoTEnterpriseS"
						)
					}
					Edition = @(
						#region CloudEdition
						@{
							Name = @(
								"CloudEdition"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.UI.Xaml.2.8"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.VP9VideoExtensions"
								"Clipchamp.Clipchamp"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.GetHelp"
								"Microsoft.Getstarted"
								"Microsoft.HEIFImageExtension"
								"Microsoft.HEVCVideoExtension"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.MinecraftEducationEdition"
								"Microsoft.Paint"
								"Microsoft.RawImageExtension"
								"Microsoft.ScreenSketch"
								"Microsoft.SecHealthUI"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Todos"
								"Microsoft.WebMediaExtensions"
								"Microsoft.WebpImageExtension"
								"Microsoft.Whiteboard"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsCalculator"
								"Microsoft.WindowsCamera"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.WindowsNotepad"
								"Microsoft.WindowsSoundRecorder"
								"Microsoft.Xbox.TCUI"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.ZuneMusic"
								"Microsoft.ZuneVideo"
								"MicrosoftCorporationII.QuickAssist"
							)
						}
						#endregion
		
						#region CloudEditionN
						@{
							Name = @(
								"CloudEditionN"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.UI.Xaml.2.8"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.XboxSpeechToTextOverlay"
								"Clipchamp.Clipchamp"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.GetHelp"
								"Microsoft.Getstarted"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.MinecraftEducationEdition"
								"Microsoft.Paint"
								"Microsoft.ScreenSketch"
								"Microsoft.SecHealthUI"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Whiteboard"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsCalculator"
								"Microsoft.WindowsCamera"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.WindowsNotepad"
								"Microsoft.XboxIdentityProvider"
								"MicrosoftCorporationII.QuickAssist"
							)
						}
						#endregion
		
						#region Group 3
						@{
							Name = @(
								"Core"
								"CoreN"
								"CoreSingleLanguage"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.UI.Xaml.2.8"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.HEIFImageExtension"
								"Microsoft.HEVCVideoExtension"
								"Microsoft.SecHealthUI"
								"Microsoft.VP9VideoExtensions"
								"Microsoft.WebpImageExtension"
								"Microsoft.WindowsStore"
								"Microsoft.GamingApp"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.Paint"
								"Microsoft.PowerAutomateDesktop"
								"Microsoft.ScreenSketch"
								"Microsoft.WindowsNotepad"
								"Microsoft.WindowsTerminal"
								"Clipchamp.Clipchamp"
								"Microsoft.MicrosoftSolitaireCollection"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.ZuneMusic"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.WindowsCamera"
								"Microsoft.Getstarted"
								"Microsoft.Cortana"
								"Microsoft.GetHelp"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.People"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Todos"
								"Microsoft.WebMediaExtensions"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsCalculator"
								"Microsoft.windowscommunicationsapps"
								"Microsoft.WindowsSoundRecorder"
								"Microsoft.Xbox.TCUI"
								"Microsoft.XboxGameOverlay"
								"Microsoft.XboxGamingOverlay"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.YourPhone"
								"Microsoft.ZuneVideo"
								"MicrosoftCorporationII.QuickAssist"
								"MicrosoftWindows.Client.WebExperience"
								"Microsoft.RawImageExtension"
								"MicrosoftCorporationII.MicrosoftFamily"
							)
						}
						#endregion
		
						#region Group 4
						@{
							Name = @(
								"Education"
								"Professional"
								"ProfessionalEducation"
								"ProfessionalWorkstation"
								"Enterprise"
								"IoTEnterprise"
								"ServerRdsh"
		
		#						"ServerStandardCore"
								"ServerStandard"
		#						"ServerDataCenterCore"
								"ServerDatacenter"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.UI.Xaml.2.8"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.HEIFImageExtension"
								"Microsoft.HEVCVideoExtension"
								"Microsoft.SecHealthUI"
								"Microsoft.VP9VideoExtensions"
								"Microsoft.WebpImageExtension"
								"Microsoft.WindowsStore"
								"Microsoft.GamingApp"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.Paint"
								"Microsoft.PowerAutomateDesktop"
								"Microsoft.ScreenSketch"
								"Microsoft.WindowsNotepad"
								"Microsoft.WindowsTerminal"
								"Clipchamp.Clipchamp"
								"Microsoft.MicrosoftSolitaireCollection"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.ZuneMusic"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.WindowsCamera"
								"Microsoft.Getstarted"
								"Microsoft.Cortana"
								"Microsoft.GetHelp"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.People"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Todos"
								"Microsoft.WebMediaExtensions"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsCalculator"
								"Microsoft.windowscommunicationsapps"
								"Microsoft.WindowsSoundRecorder"
								"Microsoft.Xbox.TCUI"
								"Microsoft.XboxGameOverlay"
								"Microsoft.XboxGamingOverlay"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.YourPhone"
								"Microsoft.ZuneVideo"
								"MicrosoftCorporationII.QuickAssist"
								"MicrosoftWindows.Client.WebExperience"
								"Microsoft.RawImageExtension"
							)
						}
						#endregion
		
						#region Group 5
						@{
							Name = @(
								"EnterpriseN"
								"EnterpriseGN"
								"EnterpriseSN"
								"ProfessionalN"
								"EducationN"
								"ProfessionalWorkstationN"
								"ProfessionalEducationN"
								"CloudN"
								"CloudEN"
								"CloudEditionLN"
								"StarterN"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.UI.Xaml.2.8"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.SecHealthUI"
								"Microsoft.WindowsStore"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.Paint"
								"Microsoft.PowerAutomateDesktop"
								"Microsoft.ScreenSketch"
								"Microsoft.WindowsNotepad"
								"Microsoft.WindowsTerminal"
								"Clipchamp.Clipchamp"
								"Microsoft.MicrosoftSolitaireCollection"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.WindowsCamera"
								"Microsoft.Getstarted"
								"Microsoft.Cortana"
								"Microsoft.GetHelp"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.People"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Todos"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsCalculator"
								"Microsoft.windowscommunicationsapps"
								"Microsoft.XboxGameOverlay"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.YourPhone"
								"MicrosoftCorporationII.QuickAssist"
								"MicrosoftWindows.Client.WebExperience"
							)
						}
						#endregion
					)
					Rule = @(
						@{ Name = "Microsoft.UI.Xaml.2.3";                  Match = "UI.Xaml*{ARCHC}*2.3";               License = "UI.Xaml*{ARCHC}*2.3";               Dependencies = @(); }
						@{ Name = "Microsoft.UI.Xaml.2.4";                  Match = "UI.Xaml*{ARCHTag}*2.4";             License = "UI.Xaml*{ARCHTag}*2.4";             Dependencies = @(); }
						@{ Name = "Microsoft.UI.Xaml.2.7";                  Match = "UI.Xaml*{ARCHTag}*2.7";             License = "UI.Xaml*{ARCHTag}*2.7";             Dependencies = @(); }
						@{ Name = "Microsoft.UI.Xaml.2.8";                  Match = "UI.Xaml*{ARCHTag}*2.8";             License = "UI.Xaml*{ARCHTag}*2.8";             Dependencies = @(); }
						@{ Name = "Microsoft.NET.Native.Framework.2.2";     Match = "Native.Framework*{ARCHTag}*2.2";    License = "Native.Framework*{ARCHTag}*2.2";    Dependencies = @(); }
						@{ Name = "Microsoft.NET.Native.Runtime.2.2";       Match = "Native.Runtime*{ARCHTag}*2.2";      License = "Native.Runtime*{ARCHTag}*2.2";      Dependencies = @(); }
						@{ Name = "Microsoft.VCLibs.140.00";                Match = "VCLibs*{ARCHTag}";                  License = "VCLibs*{ARCHTag}";                  Dependencies = @(); }
						@{ Name = "Microsoft.VCLibs.140.00.UWPDesktop";     Match = "VCLibs*{ARCHTag}*Desktop";          License = "VCLibs*{ARCHTag}*Desktop";          Dependencies = @(); }
						@{ Name = "Microsoft.Services.Store.Engagement";    Match = "Services.Store.Engagement*{ARCHC}"; License = "Services.Store.Engagement*{ARCHC}"; Dependencies = @(); }
						@{ Name = "Microsoft.HEIFImageExtension";           Match = "HEIFImageExtension";                License = "HEIFImageExtension*";               Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.HEVCVideoExtension";           Match = "HEVCVideoExtension*{ARCHC}";        License = "HEVCVideoExtension*{ARCHC}*xml";    Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.SecHealthUI";                  Match = "SecHealthUI*{ARCHC}";               License = "SecHealthUI*{ARCHC}";               Dependencies = @("Microsoft.UI.Xaml.2.4", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.VP9VideoExtensions";           Match = "VP9VideoExtensions*{ARCHC}";        License = "VP9VideoExtensions*{ARCHC}";        Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WebpImageExtension";           Match = "WebpImageExtension*{ARCHC}";        License = "WebpImageExtension*{ARCHC}";        Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsStore";                 Match = "WindowsStore";                      License = "WindowsStore";                      Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.GamingApp";                    Match = "GamingApp";                         License = "GamingApp";                         Dependencies = @("Microsoft.UI.Xaml.2.3", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.MicrosoftStickyNotes";         Match = "MicrosoftStickyNotes";              License = "MicrosoftStickyNotes";              Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Paint";                        Match = "Paint";                             License = "Paint";                             Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.UI.Xaml.2.7"); }
						@{ Name = "Microsoft.PowerAutomateDesktop";         Match = "PowerAutomateDesktop";              License = "PowerAutomateDesktop";              Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.ScreenSketch";                 Match = "ScreenSketch";                      License = "ScreenSketch";                      Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsNotepad";               Match = "WindowsNotepad";                    License = "WindowsNotepad";                    Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.UI.Xaml.2.7"); }
						@{ Name = "Microsoft.WindowsTerminal";              Match = "WindowsTerminal";                   License = "WindowsTerminal";                   Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Clipchamp.Clipchamp";                    Match = "Clipchamp.Clipchamp";               License = "Clipchamp.Clipchamp";               Dependencies = @(); }
						@{ Name = "Microsoft.MicrosoftSolitaireCollection"; Match = "MicrosoftSolitaireCollection";      License = "MicrosoftSolitaireCollection";      Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsAlarms";                Match = "WindowsAlarms";                     License = "WindowsAlarms";                     Dependencies = @("Microsoft.UI.Xaml.2.8", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.WindowsFeedbackHub";           Match = "WindowsFeedbackHub";                License = "WindowsFeedbackHub";                Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsMaps";                  Match = "WindowsMaps";                       License = "WindowsMaps";                       Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.ZuneMusic";                    Match = "ZuneMusic";                         License = "ZuneMusic";                         Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "MicrosoftCorporationII.MicrosoftFamily"; Match = "MicrosoftFamily";                   License = "MicrosoftFamily";                   Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.BingNews";                     Match = "BingNews";                          License = "BingNews";                          Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.BingWeather";                  Match = "BingWeather";                       License = "BingWeather";                       Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.DesktopAppInstaller";          Match = "DesktopAppInstaller";               License = "DesktopAppInstaller";               Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.WindowsCamera";                Match = "WindowsCamera";                     License = "WindowsCamera";                     Dependencies = @("Microsoft.UI.Xaml.2.8", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Getstarted";                   Match = "Getstarted";                        License = "Getstarted";                        Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Cortana";                      Match = "Cortana";                           License = "Cortana";                           Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.GetHelp";                      Match = "GetHelp";                           License = "GetHelp";                           Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.MicrosoftOfficeHub";           Match = "MicrosoftOfficeHub";                License = "MicrosoftOfficeHub";                Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.People";                       Match = "People";                            License = "People";                            Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.StorePurchaseApp";             Match = "StorePurchaseApp";                  License = "StorePurchaseApp";                  Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Todos";                        Match = "Todos";                             License = "Todos";                             Dependencies = @("Microsoft.UI.Xaml.2.8", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.Services.Store.Engagement"); }
						@{ Name = "Microsoft.WebMediaExtensions";           Match = "WebMediaExtensions";                License = "WebMediaExtensions";                Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Windows.Photos";               Match = "Windows.Photos";                    License = "Windows.Photos";                    Dependencies = @("Microsoft.UI.Xaml.2.4", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsCalculator";            Match = "WindowsCalculator";                 License = "WindowsCalculator";                 Dependencies = @("Microsoft.UI.Xaml.2.8", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.windowscommunicationsapps";    Match = "WindowsCommunicationsApps";         License = "WindowsCommunicationsApps";         Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsSoundRecorder";         Match = "WindowsSoundRecorder";              License = "WindowsSoundRecorder";              Dependencies = @("Microsoft.UI.Xaml.2.3", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Xbox.TCUI";                    Match = "Xbox.TCUI";                         License = "Xbox.TCUI";                         Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.XboxGameOverlay";              Match = "XboxGameOverlay";                   License = "XboxGameOverlay";                   Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.XboxGamingOverlay";            Match = "XboxGamingOverlay";                 License = "XboxGamingOverlay";                 Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.XboxIdentityProvider";         Match = "XboxIdentityProvider";              License = "XboxIdentityProvider";              Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.XboxSpeechToTextOverlay";      Match = "XboxSpeechToTextOverlay";           License = "XboxSpeechToTextOverlay";           Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.YourPhone";                    Match = "YourPhone";                         License = "YourPhone";                         Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.ZuneVideo";                    Match = "ZuneVideo";                         License = "ZuneVideo";                         Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
						@{ Name = "MicrosoftCorporationII.QuickAssist";     Match = "QuickAssist";                       License = "QuickAssist";                       Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "MicrosoftWindows.Client.WebExperience";  Match = "WebExperience";                     License = "WebExperience";                     Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.MinecraftEducationEdition";    Match = "MinecraftEducationEdition";         License = "MinecraftEducationEdition";         Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.Whiteboard";                   Match = "Whiteboard";                        License = "Whiteboard";                        Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.RawImageExtension";            Match = "RawImageExtension";                 License = "RawImageExtension";                 Dependencies = @(); }
					)
				}
				Language = @{
					ISO = @(
						@{
							ISO = "https://software-static.download.prss.microsoft.com/dbazure/988969d5-f34g-4e03-ac9d-1f9786c66749/22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso";
							CRCSHA = @{
								SHA256 = "4bb733eae9c1ebb370e976b3662ef1e707e9e7481ded1dbccae717793a42a0f0";
								SHA521 = ""
							}
						}
					)
					Rule = @(
						#region Boot
						@{
							Uid  = "Boot;Boot;Wim;"
							Rule = @(
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "WinPE-Setup_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "WINPE-SETUP-CLIENT_{Lang}.CAB";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
							)
							Repair = @(
								@{ Match = "Microsoft-Windows-Client-Language-Pack_{ARCHC}_{Lang}.cab"; Structure = "LanguagesAndOptionalFeatures"; Path = "setup\sources\{Lang}\cli"; }
							)
						}
						#endregion
		
						#region Install
						@{
							Uid  = "Install;Install;Wim;"
							Rule = @(
								@{ Match = "Microsoft-Windows-LanguageFeatures-Fonts-{DiyLang}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-Client-Language-Pack_{ARCHC}_{Lang}.cab";                                    Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Basic-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";        Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Handwriting-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";  Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-OCR-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";          Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Speech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";       Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-TextToSpeech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab"; Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";      Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-Notepad-System-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";             Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-Notepad-System-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-MediaPlayer-Package-{ARCH}-{Lang}.cab";                                      Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-MediaPlayer-Package-wow64-{Lang}.cab";                                       Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";             Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-Printing-PMCPPC-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";            Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                  Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                       Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                        Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                    Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-InternationalFeatures-{Specific}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
							)
						}
						#endregion
		
						#region WinRE
						@{
							Uid  = "Install;WinRE;Wim;"
							Rule = @(
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-appxdeployment_{Lang}.cab";  Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-appxpackaging_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-storagewmi_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wifi_{Lang}.cab";            Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-windowsupdate_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-rejuv_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-opcservices_{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-hta_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
							)
						}
						#endregion
					)
				}
			}
			#endregion
		
			#region Windows 11 22H2
			@{
				GUID        = "ec9e0561-3496-4b1a-8b29-03e60e549adf"
				Author      = "Yi"
				Copyright   = "FengYi, Inc. All rights reserved."
				Name        = "Microsoft Windows 11 22H2"
				Description = ""
				Autopilot   = @{
					Prerequisite = @{
						x64 = @{
							ISO = @{
								Language  = @(
									"22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso"
								)
								InBoxApps = @(
									"22621.1778.230511-2102.ni_release_svc_prod3_amd64fre_InboxApps.iso"
								)
							}
						}
					}
				}
				ISO         = @(
					#region Windows 11 22H2 Business editions
					@{
						ISO = "en-us_windows_11_consumer_editions_version_22h2_x64_dvd_e630fafd.iso"
						CRCSHA = @{
							SHA256 = "5c69e6f486bc4bdae91557de161008458eaa40d40468c34dbbd9078952108d0a"
							SHA512 = "dd5106557011fee70f7916f7136fdfba933d22dd6080dbbf2308426248b19db718398caa6d97835d0c776b666f6e8913b4fe71d71df5c7aa2445efa8c0a33084"
						}
					}
					@{
						ISO = "ar-sa_windows_11_consumer_editions_version_22h2_x64_dvd_5bd302c2.iso"
						CRCSHA = @{
							SHA256 = "ea7ff5bee439a12bf4ceea8ccd86b973352b847b5547d5a1c1de13c659580a21"
							SHA512 = "cc9438daabc6da49a6c29f8c8f901e1b745c14fb7c51877ab8e9493caac237ebbbdece24d8bb83acef3ef9610f694f03ebba3ba01df64a21d1e1a0eab3f39d0a"
						}
					}
					@{
						ISO = "bg-bg_windows_11_consumer_editions_version_22h2_x64_dvd_f44c4d5e.iso"
						CRCSHA = @{
							SHA256 = "ce33ae391a947eff61efac88c6a9c79fc793f431655fdfeaf73f2de91274cc09"
							SHA512 = "42146ef234ddef92243ce8f9561e378a69edf0a2ee6938b657b41fcc306ba991fff19381a1fe57762e79c107c080623f7897cac91deb6c5b5ca52c6260febadd"
						}
					}
					@{
						ISO = "cs-cz_windows_11_consumer_editions_version_22h2_x64_dvd_32969888.iso"
						CRCSHA = @{
							SHA256 = "e282f26b53c11cc4c27c8eae1f3aa9c7fac9c1f5e10177dc32772cc3abe2fc67"
							SHA512 = "23f07816f3f036b94955198f4feb99caa283fe7525e50ca5f1eee069a4f1106efb60f03becdf8eb49c75256adfdad7854151433540383879b5334a8c66ec8494"
						}
					}
					@{
						ISO = "da-dk_windows_11_consumer_editions_version_22h2_x64_dvd_a43dc176.iso"
						CRCSHA = @{
							SHA256 = "b527ac1d9a987ac93bf41b7034f86eb7f8054b42a96b6bccbaeeff96c583f4d8"
							SHA512 = "b8b78da9ee81570789fa49eb996aab9f119ef0ac3e9491a54d1e2a86a3df240ccf25ef6717958723b8eb088e3d4f4bd03e735f6fefaeecbf972f1070fbe59f46"
						}
					}
					@{
						ISO = "de-de_windows_11_consumer_editions_version_22h2_x64_dvd_308f2ec0.iso"
						CRCSHA = @{
							SHA256 = "45c0a9d8dc119260eb2a2c662d0aa3a1137d6a1466e43e29ca885168861957ee"
							SHA512 = "58375b05e1cd2e12a07b8c4bc724b7f2696555371deeb4b3506efa65467683f449f6a6d18f5213322a9eaf4497a6d808c4ec46bcdf785427884d27712dcb79f9"
						}
					}
					@{
						ISO = "el-gr_windows_11_consumer_editions_version_22h2_x64_dvd_20a044f5.iso"
						CRCSHA = @{
							SHA256 = "fc3e29822a77470b56563e2832188731b929db50064f0916a4a34c89e17d9c0f"
							SHA512 = "75d4902cfb2ca726f4f94f8a71b236d7ac23f1c895ec6055878314185f578094526d064014b9344296dfef95dbed337354bade9ba34930ed0efcf9db8cc718af"
						}
					}
					@{
						ISO = "en-gb_windows_11_consumer_editions_version_22h2_x64_dvd_f53d1d68.iso"
						CRCSHA = @{
							SHA256 = "6043e9310376e33a4cbc6a67b606e3a9313b7a0de0043ccee5ff0b66a7e00b2c"
							SHA512 = "2f199a4230de788d73e64cc1a524010bae5029fdbd63b1d81634b857b12fdc75149aed864b97505a8ba900f3cc625b5d11512d68df9dc7af3d31571de48884af"
						}
					}
					@{
						ISO = "es-es_windows_11_consumer_editions_version_22h2_x64_dvd_74378f61.iso"
						CRCSHA = @{
							SHA256 = "83c06107f16f2c1c1c55f105444949a710f5a048251c347cc5c2743d6ed6feb0"
							SHA512 = "4a60324f295ceb1e7c8b1af67b31f2998c7eaf85b865e979e0ccbaed55f083f0d0482fc4acc010020d1df7440ce300548cc21d1dd49f1c7a889f92b2ab042f36"
						}
					}
					@{
						ISO = "es-mx_windows_11_consumer_editions_version_22h2_x64_dvd_8b972bf4.iso"
						CRCSHA = @{
							SHA256 = "b81814220d797903c8da4cfeb366656014bdc868e93443cfdc894475bcf91a09"
							SHA512 = "ab4d928f141278fe01bde38254eae2123ec901f0d4f9948f921ce07e4467c9c93966b5b01250710990f4057356eb060173ba854a3ab1404e379c8d65a928e2b8"
						}
					}
					@{
						ISO = "et-ee_windows_11_consumer_editions_version_22h2_x64_dvd_0a0d278a.iso"
						CRCSHA = @{
							SHA256 = "456ce8809012930de8c54e2dba85b8094bd463dd091accefc0416c1518d6ab72"
							SHA512 = "b272600c1473e3384cabdd6be66dab051dd0dc71825efbcad70217059b0892c7d224e107b7dafbf2c59e76e3b5d7ccc1e99b092940ca2840a55b0664e834ec83"
						}
					}
					@{
						ISO = "fi-fi_windows_11_consumer_editions_version_22h2_x64_dvd_6e1f8d14.iso"
						CRCSHA = @{
							SHA256 = "b161689f139137179770903dcad30e840157f1a5f1e42b6dc8e4f6f4b8ab26a8"
							SHA512 = "db8638b3b70f2cc019068592bdba4e692c033ba687dd78c431a4ba6c6bc106496d760c50f3fac2f50a77563f547dc4e2ae66a2eca6113b451c667ec653d4408a"
						}
					}
					@{
						ISO = "fr-ca_windows_11_consumer_editions_version_22h2_x64_dvd_0f6d1c3a.iso"
						CRCSHA = @{
							SHA256 = "9d6abddae42f816120dbf23aa05d30a5d0c746abbdaf9580d887714eb1676b89"
							SHA512 = "0bf359faf01c3b5620bf489cb3c9a67fa3a4983818d9b82b0ff015a4ec6cecc16566036c6160f3a82f55135b43d0064181a98e2f7b2dc37ce63247e1eefd9954"
						}
					}
					@{
						ISO = "fr-fr_windows_11_consumer_editions_version_22h2_x64_dvd_fd644563.iso"
						CRCSHA = @{
							SHA256 = "861fbb5554f098374543de3e577d9819039887ae839ae69297b858c9c2ce2d37"
							SHA512 = "0d8e34256e6dd3e3c1cdd43fa772817eaa5ea60f6bb4d6455b6454c8c5cd5d5d200eb468baeb2501e9ed69ce0f367ee0a351094cc9a7ea3f5f03ac3718b88c7b"
						}
					}
					@{
						ISO = "he-il_windows_11_consumer_editions_version_22h2_x64_dvd_9acfb4c7.iso"
						CRCSHA = @{
							SHA256 = "f448567bf584eae3da8032bb0ffebbc54da9d07816e591a9c38857bd9c4d02f7"
							SHA512 = "08a0fe9ed233eabe827472952e19a852896fe9ec126ab73c874eae7232a2f15306d2dd5b93072e6e471a6ccbee2f169d9c6618d8a2363883d64c15dbaea795de"
						}
					}
					@{
						ISO = "hr-hr_windows_11_consumer_editions_version_22h2_x64_dvd_f9307c25.iso"
						CRCSHA = @{
							SHA256 = "db3313b9a7539eed2e00ae1d8d62cdc278104f168cf836c10c80a2ac943282c8"
							SHA512 = "7db547f7f71df1bc3c129bb20e7b860fa2b145acbd486837cb4458965efddd330a1241ec966ae855c56d09ebb768316fe67c4e8fa10916239408309679f0d8f8"
						}
					}
					@{
						ISO = "hu-hu_windows_11_consumer_editions_version_22h2_x64_dvd_1ef86b27.iso"
						CRCSHA = @{
							SHA256 = "1280ee90535fd16a77607004f7748286b305c1644a0ed7d35f9eab5e02d8b74c"
							SHA512 = "2aec01b2cae93a1d0b4a562b5ed8490cf7cc22a4e005748e9603b48f3f579edab08e8b2014cfd1a06b3ba2dfec7bdf2ed70da545a3c77774d4bbb9255ecf1e15"
						}
					}
					@{
						ISO = "it-it_windows_11_consumer_editions_version_22h2_x64_dvd_f332521c.iso"
						CRCSHA = @{
							SHA256 = "f552ec600729ff7468b338e62a12f782e663d58486d46cde2ceccb58600c77f5"
							SHA512 = "2f0d12ebb7ce5f7056b2f69eadb215db276b5ff4923b237e675e55203cd1c04f88b53a09a9a04b11307df7c28f2d12969d6e43940c404e9fa7a3864f45ff61c0"
						}
					}
					@{
						ISO = "ja-jp_windows_11_consumer_editions_version_22h2_x64_dvd_ab9135c5.iso"
						CRCSHA = @{
							SHA256 = "70554aca2dd875f8251f7b20c9cd0148d8aa507fcc2d66014eb40931a1b6bf7e"
							SHA512 = "2610c0da61b74bf8537c72c386f5c4648f30c4ff8a3f4490d774f75f651a9c8a05eb697d25279993b45627353bd33e0b576f757a5ebd9e23c1058ec0bdb230d3"
						}
					}
					@{
						ISO = "ko-kr_windows_11_consumer_editions_version_22h2_x64_dvd_aef1fb02.iso"
						CRCSHA = @{
							SHA256 = "0b48a7c4f1d0e2b4fe9d88d4a01ee2014a82078d0bcdd925bf9bf81b98d3047b"
							SHA512 = "d6f9ef666259b2ec277869a32610748cdce58467e05a5ed759d0ed514ac66956229298aaa31785965beeda30393cefd758569850d59b277225db1c1ae0eb98fa"
						}
					}
					@{
						ISO = "lt-lt_windows_11_consumer_editions_version_22h2_x64_dvd_ff4faab6.iso"
						CRCSHA = @{
							SHA256 = "661e731006266bddd1912f347f3f3ff87d1d2a256476fa37dc49600dd25af6fd"
							SHA512 = "beefba313f390245b43856f9349fa9ede85378f071c96a7b556b381a47a1895a6d31d7ba427839d7667a5df565fb62fe160cb0632e945d5883c1a0de9bacf5ed"
						}
					}
					@{
						ISO = "lv-lv_windows_11_consumer_editions_version_22h2_x64_dvd_773bd00e.iso"
						CRCSHA = @{
							SHA256 = "cbffc8f5ecd459ea6ba6f63f1dd79ab5f280c27300b9e49dfeea056cf3b04bd6"
							SHA512 = "f43139e0199b1fd0024f9537af3ee330082af9cbed0a4ec89e13e92ca5feff63df4837e42db4a219740d3796c9e003a74f1b94a0a686b87348d9d6363f762c6e"
						}
					}
					@{
						ISO = "nb-no_windows_11_consumer_editions_version_22h2_x64_dvd_6c5268ea.iso"
						CRCSHA = @{
							SHA256 = "facb2f9a5791e658e59a1dcdc200bb94d28984671ad28d41bb69ee26700b5481"
							SHA512 = "d8251fbac5cdf25f281f13f3049ba0ca1770ed9f9f4db55024ca57708ee85b9bfa2ea158c4483942b5661279449dd9c4e050c91069f8b9cf422ced05072a98d4"
						}
					}
					@{
						ISO = "nl-nl_windows_11_consumer_editions_version_22h2_x64_dvd_205af6c7.iso"
						CRCSHA = @{
							SHA256 = "93afdab010570a52eb7f04b3b11d27702297deee79b6894ac10ddae6b6652dee"
							SHA512 = "9d8935bc1da39f80c89a3608be08ae17fc9d64bafbf6e12ddc97a98c003b7501c826e4044a6ec6edd87de10a48f6f1c8216f4027cd856de27c9c5484a1ed5fed"
						}
					}
					@{
						ISO = "pl-pl_windows_11_consumer_editions_version_22h2_x64_dvd_93b008e7.iso"
						CRCSHA = @{
							SHA256 = "f6430cbd1b7071b0b7d0397dfd72c2cefbca8dcc58b3592345c834de4d2a9ce6"
							SHA512 = "287365ca1ecfde0dd3a1682ebb1e5e8b160620392c82792961670e945b0c3f2b318afab54528e0dcf258c3e5dd429f15649ffdac083f897bc41bfbe6f6e3c641"
						}
					}
					@{
						ISO = "pt-br_windows_11_consumer_editions_version_22h2_x64_dvd_b159bb92.iso"
						CRCSHA = @{
							SHA256 = "68e8ce4cbe925600f2f6b58e0c932a8179cb54202715f6aa401b1707a616f05d"
							SHA512 = "df2ff245dceed619613338dc3dfffff7809dc7d052ad591f571de357b44c47b2798844eab03dde65daa7de288cf71757e17a27ac5606186afcbdf5ff2ef885e1"
						}
					}
					@{
						ISO = "pt-pt_windows_11_consumer_editions_version_22h2_x64_dvd_675e06fe.iso"
						CRCSHA = @{
							SHA256 = "144b324ea926fc517b8d188fa39462118ac563292bc6e890fbe8e53fcfe900a6"
							SHA512 = "f0b53d2880d26992145591d9a9b3222eb120e5f72564a17a011371b92f77a511e1706928f0dd7323656b89093dd5763ede585efff38f95a6a2f851c1abf7a762"
						}
					}
					@{
						ISO = "ro-ro_windows_11_consumer_editions_version_22h2_x64_dvd_811a92ce.iso"
						CRCSHA = @{
							SHA256 = "e60530418a9d236bfede32b1eee7fb7648aa24f213443051188d6ebc4a30ed20"
							SHA512 = "9ada7c54c8411dacf3c905f84a7e17d8a07c1ffe014576724cabf9853c3de675fee7c91de6e02be3f45e06b0446f0ed48e7e53da24bb5bfd84818c63232bbe3a"
						}
					}
					@{
						ISO = "ru-ru_windows_11_consumer_editions_version_22h2_x64_dvd_e103d2b7.iso"
						CRCSHA = @{
							SHA256 = "21a0d544d0688050c18ae310ca05cf26b429b16b9c59eae3983375fdf6da5157"
							SHA512 = "e58dbcb8232b3350a0fc21aadf25f7f12da10f955474909694516575111841e63c30427a73d1096df4466bcb1e74c97f9b2b5153861200e7ab5c5dc62e4ea407"
						}
					}
					@{
						ISO = "sk-sk_windows_11_consumer_editions_version_22h2_x64_dvd_e5d9f63a.iso"
						CRCSHA = @{
							SHA256 = "351f2f7e037ed5f0ae3d882b4c74ea42ff965ad9e9590b9d056db68232464b7f"
							SHA512 = "50c74434fcdbd99407b215a28824ea87c832120ac1406c723aa66aa6966ce02e797345d67515b245d6debdc43a58708b9977aabddd23b67137fc0c757f9baba7"
						}
					}
					@{
						ISO = "sl-si_windows_11_consumer_editions_version_22h2_x64_dvd_340756e4.iso"
						CRCSHA = @{
							SHA256 = "6dab453f75a3d6afcb908c4f12cba24240a1eba2b97af64503d98fde954a2fdd"
							SHA512 = "2552db49cfbe3f02477c5cefbddf06f26af042c22ea6a6d4d9337082feccf0c6a93fceb55ebbc20169fe2bc2fe49234f24ab41c6e9c96e585a3387d3827e6171"
						}
					}
					@{
						ISO = "sr-latn-rs_windows_11_consumer_editions_version_22h2_x64_dvd_4a3fd13e.iso"
						CRCSHA = @{
							SHA256 = "640144f73dfc666c7e39e3580c2f88e0d142c7584b867cd6e72ac622948a2ab5"
							SHA512 = "e18ac3c701a4fd4a59b500f15cb2f0318e294837d8d3c3e97f2b803637c66e2b2c535811c8b020d2a42cf5f935649f4930bd8cdc90c72e78ee66f127ae6ee004"
						}
					}
					@{
						ISO = "sv-se_windows_11_consumer_editions_version_22h2_x64_dvd_1dd6443f.iso"
						CRCSHA = @{
							SHA256 = "610d4473b4861bc3adf2fe02591bdf6cdd6a17bd5dabe3aa8111d20ea036ec1c"
							SHA512 = "b142f2ce694d5549168636d8ab8cd2def45ea6a85c3ddf502c51f40ef4697d30df63506a0894a5b93fca95e2cf74c1d3e51ebb108395662f82b30ec30a749a22"
						}
					}
					@{
						ISO = "th-th_windows_11_consumer_editions_version_22h2_x64_dvd_838beade.iso"
						CRCSHA = @{
							SHA256 = "256ba7f0bed191b2f2b1761ff20d92caefd7a3cd3445a7e8ddfaa1f3333d5b77"
							SHA512 = "66ddf67d0bee1bd893d8466811e92edab354abf47f56c5ec1297e5866a9910c81981657c216d084c05850c8e8932a0c49d66d1d4346afeb2c0ac8d374fabdef5"
						}
					}
					@{
						ISO = "tr-tr_windows_11_consumer_editions_version_22h2_x64_dvd_8323319a.iso"
						CRCSHA = @{
							SHA256 = "5ebcdb6570b4d79e878ae22fe114d0ec4ab176afab2808d8e447e589ebda7344"
							SHA512 = "4e66117fbcd393460d37d3cf35b11ebe4b5acbcfe8b272dd90c393e1187c092606f15720c2331893cc9c6ae8ca6cad7e58f69ee47ccbdb95b49807757da93816"
						}
					}
					@{
						ISO = "uk-ua_windows_11_consumer_editions_version_22h2_x64_dvd_cbb899ba.iso"
						CRCSHA = @{
							SHA256 = "054559865e7065a84c433c82384f5348b52678d472410eb02896a45dd7247bb7"
							SHA512 = "29da5b11c38de460c9cef5ea3d23d06f5167378b75ca0d811990447a4bb15fcc110936475b13f5e50159e5d0654fc7ff49fa5fc0649cb254aab8d67c85d95b56"
						}
					}
					@{
						ISO = "zh-cn_windows_11_consumer_editions_version_22h2_x64_dvd_59cfe6ee.iso"
						CRCSHA = @{
							SHA256 = "5d4733ad43ee51b7686b766d1dd691342a8421035e7c9fa0c936b7babee0be4b"
							SHA512 = "5b6da83c352573773e5c08acaa86d75532cfcc9dae7afa5ed2a5dbcbbd165a3410bbd5c232a99e30342c5e53e2de20e6cf04ec62e99358a75e5f0fffa8320a2b"
						}
					}
					@{
						ISO = "zh-tw_windows_11_consumer_editions_version_22h2_x64_dvd_e31b7c9d.iso"
						CRCSHA = @{
							SHA256 = "0da9e7c321ceb12536420f21a716c3240235ed0af48d71f065ec76ae77a58edb"
							SHA512 = "3a73514e165d5383e97d9b4b9978cc9b1da3720fe7586f706a88b051e24fa9bd1fe32959b16659e5b7903b937af715b4e30dad8148b4877595ebe4071cffe381"
						}
					}
		
					#region Windows 11 22H2 Consumer editions
					@{
						ISO = "en-us_windows_11_business_editions_version_22h2_x64_dvd_17a08ce3.iso"
						CRCSHA = @{
							SHA256 = "6e3a101c6e97d8e68f576ddbced9be34cba949f750da3c83f7d4791401068c9f"
							SHA512 = "d9d134d3fd5c6adfb0d193773ffb115d6384208462ba2dcf574eb74f3bc3d38c84e56366395d96cd5c346932060f3a392e6b02f0b0a4ae8c71b7f4f5d6667bdb"
						}
					}
					@{
						ISO = "ar-sa_windows_11_business_editions_version_22h2_x64_dvd_f540460b.iso"
						CRCSHA = @{
							SHA256 = "106b5e7c81e9eb3482b4785e4f80f671b8b810dbb5e99ce73f6887700c43944b"
							SHA512 = "06a1f438e538a7da81a4e1276ae829a974b4d71852484fd76ff1fb436c4f6a3fe180a22bd4519a402a1d164aa3da47292e2237a990097dd362a707b3b0caff2f"
						}
					}
					@{
						ISO = "bg-bg_windows_11_business_editions_version_22h2_x64_dvd_a56bdb70.iso"
						CRCSHA = @{
							SHA256 = "ccd6db67777cf5aab0a2404b7f28491980cf5c5cf06215c84e88b1a32367a28b"
							SHA512 = "ae4b9601801064b33c61032a7263be09203526625497550a577748d48e9610b4b72b42a8457e7520355e136ba4623a69d0fe83d1cb6dfe696cdebaf4b804211c"
						}
					}
					@{
						ISO = "cs-cz_windows_11_business_editions_version_22h2_x64_dvd_73382dfe.iso"
						CRCSHA = @{
							SHA256 = "2904a01415fff30732c140af12c2bb8909d907b7855eb33193c261ef3f2ae671"
							SHA512 = "e4d2cbc66152e35112c2b02c27e77be8cb1586606602b9bc68fcbcd8ea681d6520e1358380b5aa0148afc752a948e0125a93b0f2c8f6d75bf525687cf05f003d"
						}
					}
					@{
						ISO = "da-dk_windows_11_business_editions_version_22h2_x64_dvd_e82be8a3.iso"
						CRCSHA = @{
							SHA256 = "1c06487dd2bb93ff762f6799cfc7133423eac9bd647e4d18aebd0ae9a0c6e703"
							SHA512 = "d3048e76cb02572a9b7132c85317b2371a06ea062de5f33e145977640e061f1790098f27279160bc39d65ebc838f310e6c4d125c69e777978b60af3077a10d4f"
						}
					}
					@{
						ISO = "de-de_windows_11_business_editions_version_22h2_x64_dvd_9251151c.iso"
						CRCSHA = @{
							SHA256 = "14985051022834ca5fce6a31b409bb01d3d50a0f6afbe3ab2ed4ebc499ca03df"
							SHA512 = "3c311e92e62039e96e57db1d53bae12f5f98026880499b45a133f4e602c36e57d0434d5b5e0313e0a43afa8324e2b88d972e0c802825fd1ebfb18c61c55b5a26"
						}
					}
					@{
						ISO = "el-gr_windows_11_business_editions_version_22h2_x64_dvd_6c1bf17c.iso"
						CRCSHA = @{
							SHA256 = "8a484a2962c708246eaa2afd03f2e066aafdab075aa6689430856f381c85275a"
							SHA512 = "eeed2f3dbdc5371f8f4a87409247273a7f79b53ae7cf85738416048aa697724dbdc9c3a2571e74bce3a2d55057bae2b06ad4c98d1aafb2995dd3bedd02eb4ea1"
						}
					}
					@{
						ISO = "en-gb_windows_11_business_editions_version_22h2_x64_dvd_c8309780.iso"
						CRCSHA = @{
							SHA256 = "4af045e9780507159d557ca49dc4beca62d6337b32e80528bf29348eec297c10"
							SHA512 = "bfdfd2418cca44796d5d08cfc4442af7dba9862f8574736d11fa8600ae46f25cc67ae5f025ff874f606f5bd7d476799d41dfc35c7b0a19550cced3187b3751e8"
						}
					}
					@{
						ISO = "es-es_windows_11_business_editions_version_22h2_x64_dvd_046f84e3.iso"
						CRCSHA = @{
							SHA256 = "049d36d9dfcf23850b578a816760906c4c5d4e900a9eea02833dff35b9253ace"
							SHA512 = "0ccad32d17150b7dd89d821207bffcd2a1424d7c5282c057c82ddd59480973d8668a64921461e9e223c1ba31b11d8600000f34dc1f1fc0c4f31de01d41a17606"
						}
					}
					@{
						ISO = "es-mx_windows_11_business_editions_version_22h2_x64_dvd_2b40a1bc.iso"
						CRCSHA = @{
							SHA256 = "f4b14e4fb15eaf9799f0a07996ec4c9502e1891193e6b51cd7da04b60ab8d6e9"
							SHA512 = "3b7748509a29aece5a2d49dcf50305bfa98342129b0d584748d36ffd2aed463aee494a89ca6407b4ca6befe713fef3a25cb311fee123ac9239b7894a9f971032"
						}
					}
					@{
						ISO = "et-ee_windows_11_business_editions_version_22h2_x64_dvd_5091a0c2.iso"
						CRCSHA = @{
							SHA256 = "16d4d61b65fcf24f242320407c85440448bf9a9e5c070bfc8f394bd37077d406"
							SHA512 = "59994770b9a0ae8dc6485315a49a1e19c8b5df54ade5d4a17766c50609fdee0c77f1c508fc14df4d5cc68705e09a4883fb34ab527ce3ab49befd2292c964f8a9"
						}
					}
					@{
						ISO = "fi-fi_windows_11_business_editions_version_22h2_x64_dvd_faff1258.iso"
						CRCSHA = @{
							SHA256 = "d4dde91addff76a16b7dd4f7fb73a700e534e207b2dc4d41ddccd36119719aad"
							SHA512 = "248b19c0d61a1498341cfd1baf1e1c478219a3b03311425b6ffc1435bfb6fca81f81e7341c1be0a5c41c4b93e9d91b8401c1ac36c6ea6d5220c7f7c2489b5679"
						}
					}
					@{
						ISO = "fr-ca_windows_11_business_editions_version_22h2_x64_dvd_b3b3de14.iso"
						CRCSHA = @{
							SHA256 = "ec46ce004ab4dbf5ffefcb1f866f51f3cffb7b5adb42ffa141b6167f4fbaada4"
							SHA512 = "6a6940ff2853aa4879d098372d85a7650b71c9e605bdbd174f1f176dad6f7fe277a3f12584b8ba95647be8f51247cd97074bae4d3c710e217572f731000a887e"
						}
					}
					@{
						ISO = "fr-fr_windows_11_business_editions_version_22h2_x64_dvd_daa45106.iso"
						CRCSHA = @{
							SHA256 = "2d8192e699e4a00c447f009035c626874f680ab25a83baf5c5b14899917c9b5e"
							SHA512 = "660facbd04928d05f498bf2b8f404d9201cd53e9d3cdacfa779e6088e4beb32a39e2421869b5ad0d94dd3e794324e048ce3090add36fcc7693b95a8d3f56e319"
						}
					}
					@{
						ISO = "he-il_windows_11_business_editions_version_22h2_x64_dvd_5d9efb22.iso"
						CRCSHA = @{
							SHA256 = "8308a21c46ca382aed8be0d8c33b4debfa5aed0b88057f2be75e1412fc0619fe"
							SHA512 = "873ee67ff576884fb9aae65fcc6fff63971e4649261e9ebc8fed0290e40130581cbd870c798fd00d6d1ca0173cb100f82df02044a8b20c1150ecf58895e9edf3"
						}
					}
					@{
						ISO = "hr-hr_windows_11_business_editions_version_22h2_x64_dvd_59c5e55f.iso"
						CRCSHA = @{
							SHA256 = "535297cf660e07bc2c49ce72432029049600c06122b1347bcaf40ac357a3cfa5"
							SHA512 = "b74c840b2923aa1fb7979fb5d9f6fb91d50439a8dbc1cdc74dad73fb68a9f2faa73433c5cc1474e304550166e7b54b94f648ab482d27283bb45556dad28f8bc4"
						}
					}
					@{
						ISO = "hu-hu_windows_11_business_editions_version_22h2_x64_dvd_bb43f59e.iso"
						CRCSHA = @{
							SHA256 = "c11f4ddc7231c977b39a6bb7e45e3a99191a8f2664d00f02c03d40dd42f4d89c"
							SHA512 = "63af0c5b8575f4aa8f1d2ec59eb817f1ce97a908c8022aa10313f408860b3e25b17ea54939ca3715e89412056b3e6bdd24cedb49fbfbb05887f1fe0aa58c7966"
						}
					}
					@{
						ISO = "it-it_windows_11_business_editions_version_22h2_x64_dvd_96d3b1d5.iso"
						CRCSHA = @{
							SHA256 = "1795b3d80bd4f8c479d96c763b6c5127246ddeb03f2008819c2fd40ca366dd38"
							SHA512 = "a2feb940edb7c3b4b53f7b71bcd8864a04b536d3c98ae0cb8937f1933ea1847ec8662daa1a5bee5f880ccf128ad9462a6c472086edb7971e0dc2938cb8a1f713"
						}
					}
					@{
						ISO = "ja-jp_windows_11_business_editions_version_22h2_x64_dvd_02784601.iso"
						CRCSHA = @{
							SHA256 = "bf14c2d1a5701df2c57d402315971bd80e708df9cb98eb44dc1fb971a1b56cee"
							SHA512 = "58db4a96156003cad1d6986035b3c19d6e85ba37557a4d960ebe97b2957978f6e0a1f1fa0eacf62cf90f552d0e717d9592aa6a4a0934caad9dc0016d132d1778"
						}
					}
					@{
						ISO = "ko-kr_windows_11_business_editions_version_22h2_x64_dvd_86adcdbb.iso"
						CRCSHA = @{
							SHA256 = "478258f9977276e4baa8795505ff3ee7b5ab841d6751219e91582e5439332671"
							SHA512 = "721a724ce6642d6a4977fc833b57b7d5ff021b81efdd2d30ae20ebae1e51581bc851b5d9a3c37ee6c2d04c68ac9cc45851b24baa79c919f02b661bb1f811f9e6"
						}
					}
					@{
						ISO = "lt-lt_windows_11_business_editions_version_22h2_x64_dvd_1363447f.iso"
						CRCSHA = @{
							SHA256 = "ae2ec2517f1fd9de0c0dae497fbbf59ef5de6ebf41c9cca6f0aff093870a2db0"
							SHA512 = "65838dd933686943afc20ce57f3d9f197b4224ea9d537399c8c7324d0fa68bfd1c5ea7240c50f4cb93d09df97b027d93dc50a01136e165c9746dd12c55a620a8"
						}
					}
					@{
						ISO = "lv-lv_windows_11_business_editions_version_22h2_x64_dvd_0e08f3d6.iso"
						CRCSHA = @{
							SHA256 = "474e04880e290b96b1e6aee5661e1d273237d342f59e87af4390c20e0d79d351"
							SHA512 = "fa443e3bea4744616bd48ec2e3b296be81a892aecf72c3d9ae1a82c6b0f78676857294e80e5e62d7a6838f4d0efccf174dcf9fe2053a6c0baa668e6fce9698d5"
						}
					}
					@{
						ISO = "nb-no_windows_11_business_editions_version_22h2_x64_dvd_f9122657.iso"
						CRCSHA = @{
							SHA256 = "a748bb4785136a37c7553f4377e78fe2c157f81b4da09d853cbbda2197d251ff"
							SHA512 = "b868102099a13ab83668710fc78f5e5346a1e0b625c8b99516ae875de95c6904cc0626f4a946b90baae6a5ba36836d178413dcf6273f429868dce5b8c948cbfe"
						}
					}
					@{
						ISO = "nl-nl_windows_11_business_editions_version_22h2_x64_dvd_1c1a31d6.iso"
						CRCSHA = @{
							SHA256 = "68f536890a2e94028dbc4459b1202f7da572e4e4f6ec96746f79b11737ab1518"
							SHA512 = "29b5e93b8a687ca7a89862efae982ae7c1cfbea0504a0cd8f6678fb3842a90879519b000940e2bb2f930f26a5bccf6975781d8f837f8c28c0f9d2c1761daf190"
						}
					}
					@{
						ISO = "pl-pl_windows_11_business_editions_version_22h2_x64_dvd_29f306ac.iso"
						CRCSHA = @{
							SHA256 = "961ec5180b0e7805c407d753efd1a9b57499bb5816577b759239717fb40eeaee"
							SHA512 = "753cb23608f45f7b3bc2bba137df13cc3f72ce9a2647d51d9893156f8f90bbeea7d2f841e9d59e7f1471f8f1baecc818780316fbdb7f24c382ff8ece3774a6b0"
						}
					}
					@{
						ISO = "pt-br_windows_11_business_editions_version_22h2_x64_dvd_e342d0ea.iso"
						CRCSHA = @{
							SHA256 = "caec31ba23edb1722659ef224bf500f3d28d37525ddf5885350cbb4d63a4efd5"
							SHA512 = "2e2374902927ee4c2bc32a50414350f1ecf28bf482a829a4a78fe604b0aec935608f55e3ec97937c9c0a5f99f6f7b96074ff4dc6cb6f865481efb2bdbeea7e79"
						}
					}
					@{
						ISO = "pt-pt_windows_11_business_editions_version_22h2_x64_dvd_6599e159.iso"
						CRCSHA = @{
							SHA256 = "790b0c6adb0ba192f427ed9141c121dfa571681da67e0b9cf5658c1d9e0087f1"
							SHA512 = "6c32a9efaa7dc04825104bc1d04a4caed8773f88ab0aa42e4054c37204f111dbd0f922b1b4fcc606878ee7a43bf3df5c225b13a7b8aa957edb61878fe12c534e"
						}
					}
					@{
						ISO = "ro-ro_windows_11_business_editions_version_22h2_x64_dvd_0d1cb130.iso"
						CRCSHA = @{
							SHA256 = "875afd121f93f4ec26d7ea823aa53eb9bddd10cd0bf5888fab472c61f3701eed"
							SHA512 = "767de1b0e12bd6c1ba332e0e5a0b8f7777de1a273611d98d0956837d57aa6431e762a3847a5d49dac6de59bb013da9407923d52f5e79c5e9349c7fe51e06d5c7"
						}
					}
					@{
						ISO = "ru-ru_windows_11_business_editions_version_22h2_x64_dvd_64f7a2da.iso"
						CRCSHA = @{
							SHA256 = "d2d8e837d8e44b5cf7e64aa60c45c2474ea1e66c17b7d139fd6885f2df2a10ce"
							SHA512 = "21d5836547fb08a9753a95629472dceb65993e6723124e5f2bb77ee6def3bc324da2f0a576da0cc5531b705677309d204ff091057f95a916d9219aa2a609d234"
						}
					}
					@{
						ISO = "sk-sk_windows_11_business_editions_version_22h2_x64_dvd_d04cfcad.iso"
						CRCSHA = @{
							SHA256 = "47e08af8ea94b32861bdaf7a4bc6a38ed3fb888078a7fd29359a11fd8ec8b328"
							SHA512 = "577ab57dd82b270817678717ba1e3cb1db2a96d47452c8f0f9f58cc718a914f1b9632977ac8aa004548873c9bbd44a441a7526e531815d09bef1a157529df3c7"
						}
					}
					@{
						ISO = "sl-si_windows_11_business_editions_version_22h2_x64_dvd_fe750abf.iso"
						CRCSHA = @{
							SHA256 = "01a006b29ff73accf21655e811440202ee1c4ed645918956e4f35074becf64f8"
							SHA512 = "0718b12427402ebef0fa939cf312f339855fb10d5a077fa5c6355113b230505cc0f1967ba0d43c0e697401c6f29cb2a2c0c71638866715669b6e2cd8fa980c63"
						}
					}
					@{
						ISO = "sr-latn-rs_windows_11_business_editions_version_22h2_x64_dvd_f424bc70.iso"
						CRCSHA = @{
							SHA256 = "0085f12e6ec0a6117cf0036637452ab18f4d80287ff69338d6ec5b57ba940465"
							SHA512 = "f38a71ea2c55c0d0bb91e637bd3bdf6fa95bc745b4ee6ce25c03f2e79c24004c269b5e9be5008dd74dd77ded5d5f848822cf853d753e0da2cd52bcb3c093511c"
						}
					}
					@{
						ISO = "sv-se_windows_11_business_editions_version_22h2_x64_dvd_56f9abed.iso"
						CRCSHA = @{
							SHA256 = "dc844b6854ee6cf93a8622bbda421b80db63e64f00c35cf9ab5f45b62198bc5f"
							SHA512 = "4bcdb227f68ed3ccaf0567dc4a9f441fdbf0d9237cd0f261e640d9a2be8bac4ae8183c19d97e174adff928bf5202c2f50df0718dee14da1ff0f2f2fcc8e6fc5f"
						}
					}
					@{
						ISO = "th-th_windows_11_business_editions_version_22h2_x64_dvd_d2ac94ef.iso"
						CRCSHA = @{
							SHA256 = "0deaf536a805b381c950ee18571d734b34f61d8d65ca1398de022085920dd7f9"
							SHA512 = "afdbc7f79f18591ce65d75c1ee12434c243ec5bad9dd29a7ddb676920733e2fb45d005c4dbd9e2b5d1d050e61cbf56fef5120232f5b417dfbc1efb1d623a9b01"
						}
					}
					@{
						ISO = "tr-tr_windows_11_business_editions_version_22h2_x64_dvd_2d9d9a63.iso"
						CRCSHA = @{
							SHA256 = "403d63dd7a5be5704ce106228d409cdbba7706636dda9416b132254fcc1d78c2"
							SHA512 = "f43d4e395692de1101e2fa00fd71af57358916e38c402b8d9be9a2e84ec3f2631bb8f16cd94b68eae4d6e25593b5f35dd61411b984fccb9f4222a2d3e9d3b598"
						}
					}
					@{
						ISO = "uk-ua_windows_11_business_editions_version_22h2_x64_dvd_b714596b.iso"
						CRCSHA = @{
							SHA256 = "c10829e67ff4629404829366dfb84174ac2d0fa1dc50a119bdbf4feea2b1d948"
							SHA512 = "41b80f0edc6c868d42bd768a5069d6e2a758cdce70dc16386ce2d6c7334bb1df102c0d6338c28c1100310dde0e933ace41501089c67c3922f7ff2b51e91ea9dd"
						}
					}
					@{
						ISO = "zh-cn_windows_11_business_editions_version_22h2_x64_dvd_914b57a5.iso"
						CRCSHA = @{
							SHA256 = "d74d24a00f83e77a189be6bcb2e23fad5babc29f576e810c43282ce683f8b048"
							SHA512 = "5a408f050b8385e77d583b3de07086df8b640d6c5af2d376ee71c98dba9481a60dabda785e85bcd197ce19b5c7ad747bba8cabf1bb1ff28f902b41f99a5796ad"
						}
					}
					@{
						ISO = "zh-tw_windows_11_business_editions_version_22h2_x64_dvd_2bc4a530.iso"
						CRCSHA = @{
							SHA256 = "4c691d1c01ccb40275baf979db1a9cec98f7da8a8dfa59b4d2366eec76084758"
							SHA512 = "ba4700451e1081dffaaad09378324a90acd14d56249dd30145d593c9abe9622a6e401910462f502e44aa344df05f8ca750ba5a9656226c2037751039ffbe8792"
						}
					}
		
					#region Windows 11 IoT Enterprise 22H2
					@{
						ISO = "en-us_windows_11_iot_enterprise_version_22h2_x64_dvd_eb39bf70.iso"
						CRCSHA = @{
							SHA256 = "4EE24C002B6B8B710A44E065B44AA3990FD9816516BCA4108F2E28190B7CA007"
							SHA512 = "80fd4aa1bf5dd7f81591946c2773e601237391d3b6f41203f20a565390cb1527c5e3715cc7fd40a5f27258877e498dfd9ce8a39f8ba4be0840945968d99f7f86"
						}
					}
					@{
						ISO = "en-us_windows_11_iot_enterprise_version_22h2_arm64_dvd_f09f5d29.iso"
						CRCSHA = @{
							SHA256 = "5EB8135591904A30332F2EDC7A4EA018059C25C87FAD2DCB84BD167002EE4596"
							SHA512 = "f4d47169120b983d4808c343c11b56843d9da657f85204b6187aac6315560b1067ea6f234e24ea55d26f01dfa55d66c93176e041194eee66ec9e1cf02837f5b7"
						}
					}
		
				)
				InboxApps   = @{
					ISO = @(
						@{
							ISO = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/22621.1778.230511-2102.ni_release_svc_prod3_amd64fre_InboxApps.iso"
							CRCSHA = @{
								SHA256 = "cb3a7f9f13f17da3c5d1148ae2d3a1112f0ec84aeb1853a5046778f8aff26879"
								SHA512 = ""
							}
						}
						@{
							ISO = "https://software-static.download.prss.microsoft.com/dbazure/988969d5-f34g-4e03-ac9d-1f9786c66749/22621.1.220506-1250.ni_release_amd64fre_InboxApps.iso"
							CRCSHA = @{
								SHA256 = "7691bd15d2c7ec7308164cb9f39997f888ed428b4b02abd2d4fb773df5647596"
								SHA512 = "aae5988e2ce0c2b1d939438de1c957a687812ee5b83dea66f55f7145385dad5ea2c0f72bc80c17dba1589ed84af1ff4e664c58e9c05fd65146f88f742f790d90"
							}
						}
					)
					SN = @{
						Edition = @(
							"EnterpriseS"
							"EnterpriseSN"
							"IoTEnterpriseS"
						)
					}
					Edition = @(
						#region CloudEdition
						@{
							Name = @(
								"CloudEdition"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.VP9VideoExtensions"
								"Clipchamp.Clipchamp"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.GetHelp"
								"Microsoft.Getstarted"
								"Microsoft.HEIFImageExtension"
								"Microsoft.HEVCVideoExtension"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.MinecraftEducationEdition"
								"Microsoft.Paint"
								"Microsoft.RawImageExtension"
								"Microsoft.ScreenSketch"
								"Microsoft.SecHealthUI"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Todos"
								"Microsoft.WebMediaExtensions"
								"Microsoft.WebpImageExtension"
								"Microsoft.Whiteboard"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsCalculator"
								"Microsoft.WindowsCamera"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.WindowsNotepad"
								"Microsoft.WindowsSoundRecorder"
								"Microsoft.Xbox.TCUI"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.ZuneMusic"
								"Microsoft.ZuneVideo"
								"MicrosoftCorporationII.QuickAssist"
							)
						}
						#endregion
		
						#region CloudEditionN
						@{
							Name = @(
								"CloudEditionN"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.XboxSpeechToTextOverlay"
								"Clipchamp.Clipchamp"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.GetHelp"
								"Microsoft.Getstarted"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.MinecraftEducationEdition"
								"Microsoft.Paint"
								"Microsoft.ScreenSketch"
								"Microsoft.SecHealthUI"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Whiteboard"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsCalculator"
								"Microsoft.WindowsCamera"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.WindowsNotepad"
								"Microsoft.XboxIdentityProvider"
								"MicrosoftCorporationII.QuickAssist"
							)
						}
						#endregion
		
						#region Group 3
						@{
							Name = @(
								"Core"
								"CoreN"
								"CoreSingleLanguage"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.HEIFImageExtension"
								"Microsoft.HEVCVideoExtension"
								"Microsoft.SecHealthUI"
								"Microsoft.VP9VideoExtensions"
								"Microsoft.WebpImageExtension"
								"Microsoft.WindowsStore"
								"Microsoft.GamingApp"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.Paint"
								"Microsoft.PowerAutomateDesktop"
								"Microsoft.ScreenSketch"
								"Microsoft.WindowsNotepad"
								"Microsoft.WindowsTerminal"
								"Clipchamp.Clipchamp"
								"Microsoft.MicrosoftSolitaireCollection"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.ZuneMusic"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.WindowsCamera"
								"Microsoft.Getstarted"
								"Microsoft.Cortana"
								"Microsoft.GetHelp"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.People"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Todos"
								"Microsoft.WebMediaExtensions"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsCalculator"
								"Microsoft.windowscommunicationsapps"
								"Microsoft.WindowsSoundRecorder"
								"Microsoft.Xbox.TCUI"
								"Microsoft.XboxGameOverlay"
								"Microsoft.XboxGamingOverlay"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.YourPhone"
								"Microsoft.ZuneVideo"
								"MicrosoftCorporationII.QuickAssist"
								"MicrosoftWindows.Client.WebExperience"
								"Microsoft.RawImageExtension"
								"MicrosoftCorporationII.MicrosoftFamily"
							)
						}
						#endregion
		
						#region Group 4
						@{
							Name = @(
								"Education"
								"Professional"
								"ProfessionalEducation"
								"ProfessionalWorkstation"
								"Enterprise"
								"IoTEnterprise"
								"ServerRdsh"
		
		#						"ServerStandardCore"
								"ServerStandard"
		#						"ServerDataCenterCore"
								"ServerDatacenter"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.HEIFImageExtension"
								"Microsoft.HEVCVideoExtension"
								"Microsoft.SecHealthUI"
								"Microsoft.VP9VideoExtensions"
								"Microsoft.WebpImageExtension"
								"Microsoft.WindowsStore"
								"Microsoft.GamingApp"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.Paint"
								"Microsoft.PowerAutomateDesktop"
								"Microsoft.ScreenSketch"
								"Microsoft.WindowsNotepad"
								"Microsoft.WindowsTerminal"
								"Clipchamp.Clipchamp"
								"Microsoft.MicrosoftSolitaireCollection"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.ZuneMusic"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.WindowsCamera"
								"Microsoft.Getstarted"
								"Microsoft.Cortana"
								"Microsoft.GetHelp"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.People"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Todos"
								"Microsoft.WebMediaExtensions"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsCalculator"
								"Microsoft.windowscommunicationsapps"
								"Microsoft.WindowsSoundRecorder"
								"Microsoft.Xbox.TCUI"
								"Microsoft.XboxGameOverlay"
								"Microsoft.XboxGamingOverlay"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.YourPhone"
								"Microsoft.ZuneVideo"
								"MicrosoftCorporationII.QuickAssist"
								"MicrosoftWindows.Client.WebExperience"
								"Microsoft.RawImageExtension"
							)
						}
						#endregion
		
						#region Group 5
						@{
							Name = @(
								"EnterpriseN"
								"EnterpriseGN"
								"EnterpriseSN"
								"ProfessionalN"
								"EducationN"
								"ProfessionalWorkstationN"
								"ProfessionalEducationN"
								"CloudN"
								"CloudEN"
								"CloudEditionLN"
								"StarterN"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.UI.Xaml.2.4"
								"Microsoft.UI.Xaml.2.7"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.SecHealthUI"
								"Microsoft.WindowsStore"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.Paint"
								"Microsoft.PowerAutomateDesktop"
								"Microsoft.ScreenSketch"
								"Microsoft.WindowsNotepad"
								"Microsoft.WindowsTerminal"
								"Clipchamp.Clipchamp"
								"Microsoft.MicrosoftSolitaireCollection"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.BingNews"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.WindowsCamera"
								"Microsoft.Getstarted"
								"Microsoft.Cortana"
								"Microsoft.GetHelp"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.People"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Todos"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsCalculator"
								"Microsoft.windowscommunicationsapps"
								"Microsoft.XboxGameOverlay"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.YourPhone"
								"MicrosoftCorporationII.QuickAssist"
								"MicrosoftWindows.Client.WebExperience"
							)
						}
						#endregion
					)
					Rule = @(
						@{ Name = "Microsoft.UI.Xaml.2.3";                  Match = "UI.Xaml*{ARCHTag}*2.3";          License = "UI.Xaml*{ARCHTag}*2.3";          Dependencies = @(); }
						@{ Name = "Microsoft.UI.Xaml.2.4";                  Match = "UI.Xaml*{ARCHTag}*2.4";          License = "UI.Xaml*{ARCHTag}*2.4";          Dependencies = @(); }
						@{ Name = "Microsoft.UI.Xaml.2.7";                  Match = "UI.Xaml*{ARCHTag}*2.7";          License = "UI.Xaml*{ARCHTag}*2.7";          Dependencies = @(); }
						@{ Name = "Microsoft.NET.Native.Framework.2.2";     Match = "Native.Framework*{ARCHTag}*2.2"; License = "Native.Framework*{ARCHTag}*2.2"; Dependencies = @(); }
						@{ Name = "Microsoft.NET.Native.Runtime.2.2";       Match = "Native.Runtime*{ARCHTag}*2.2";   License = "Native.Runtime*{ARCHTag}*2.2";   Dependencies = @(); }
						@{ Name = "Microsoft.VCLibs.140.00";                Match = "VCLibs*{ARCHTag}";               License = "VCLibs*{ARCHTag}";               Dependencies = @(); }
						@{ Name = "Microsoft.VCLibs.140.00.UWPDesktop";     Match = "VCLibs*{ARCHTag}*Desktop";       License = "VCLibs*{ARCHTag}*Desktop";       Dependencies = @(); }
						@{ Name = "Microsoft.HEIFImageExtension";           Match = "HEIFImageExtension";             License = "HEIFImageExtension*";            Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.HEVCVideoExtension";           Match = "HEVCVideoExtension*{ARCHC}";     License = "HEVCVideoExtension*{ARCHC}*xml"; Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.SecHealthUI";                  Match = "SecHealthUI*{ARCHC}";            License = "SecHealthUI*{ARCHC}";            Dependencies = @("Microsoft.UI.Xaml.2.4", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.VP9VideoExtensions";           Match = "VP9VideoExtensions*{ARCHC}";     License = "VP9VideoExtensions*{ARCHC}";     Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WebpImageExtension";           Match = "WebpImageExtension*{ARCHC}";     License = "WebpImageExtension*{ARCHC}";     Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsStore";                 Match = "WindowsStore";                   License = "WindowsStore";                   Dependencies = @("Microsoft.UI.Xaml.2.3", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.GamingApp";                    Match = "GamingApp";                      License = "GamingApp";                      Dependencies = @("Microsoft.UI.Xaml.2.3", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.MicrosoftStickyNotes";         Match = "Microsoft.Sticky.Notes";         License = "MicrosoftStickyNotes";           Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Paint";                        Match = "Paint";                          License = "Paint";                          Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.UI.Xaml.2.7"); }
						@{ Name = "Microsoft.PowerAutomateDesktop";         Match = "PowerAutomateDesktop";           License = "PowerAutomateDesktop";           Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.ScreenSketch";                 Match = "ScreenSketch";                   License = "ScreenSketch";                   Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsNotepad";               Match = "WindowsNotepad";                 License = "WindowsNotepad";                 Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.UI.Xaml.2.7"); }
						@{ Name = "Microsoft.WindowsTerminal";              Match = "WindowsTerminal";                License = "WindowsTerminal";                Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Clipchamp.Clipchamp";                    Match = "Clipchamp.Clipchamp";            License = "Clipchamp.Clipchamp";            Dependencies = @(); }
						@{ Name = "Microsoft.MicrosoftSolitaireCollection"; Match = "MicrosoftSolitaireCollection";   License = "MicrosoftSolitaireCollection";   Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsAlarms";                Match = "WindowsAlarms";                  License = "WindowsAlarms";                  Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsFeedbackHub";           Match = "WindowsFeedbackHub";             License = "WindowsFeedbackHub";             Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsMaps";                  Match = "WindowsMaps";                    License = "WindowsMaps";                    Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.ZuneMusic";                    Match = "ZuneMusic";                      License = "ZuneMusic";                      Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
						@{ Name = "MicrosoftCorporationII.MicrosoftFamily"; Match = "MicrosoftFamily";                License = "MicrosoftFamily";                Dependencies = @(); }
						@{ Name = "Microsoft.BingNews";                     Match = "BingNews";                       License = "BingNews";                       Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.BingWeather";                  Match = "BingWeather";                    License = "BingWeather";                    Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.DesktopAppInstaller";          Match = "DesktopAppInstaller";            License = "DesktopAppInstaller";            Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.WindowsCamera";                Match = "WindowsCamera";                  License = "WindowsCamera";                  Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Getstarted";                   Match = "Getstarted";                     License = "Getstarted";                     Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Cortana";                      Match = "Cortana";                        License = "Cortana";                        Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.GetHelp";                      Match = "GetHelp";                        License = "GetHelp";                        Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.MicrosoftOfficeHub";           Match = "MicrosoftOfficeHub";             License = "MicrosoftOfficeHub";             Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.People";                       Match = "People";                         License = "People";                         Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.StorePurchaseApp";             Match = "StorePurchaseApp";               License = "StorePurchaseApp";               Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Todos";                        Match = "Todos";                          License = "Todos";                          Dependencies = @("Microsoft.UI.Xaml.2.4", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WebMediaExtensions";           Match = "WebMediaExtensions";             License = "WebMediaExtensions";             Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Windows.Photos";               Match = "Windows.Photos";                 License = "Windows.Photos";                 Dependencies = @("Microsoft.UI.Xaml.2.4", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsCalculator";            Match = "WindowsCalculator";              License = "WindowsCalculator";              Dependencies = @("Microsoft.UI.Xaml.2.4", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.windowscommunicationsapps";    Match = "WindowsCommunicationsApps";      License = "WindowsCommunicationsApps";      Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.WindowsSoundRecorder";         Match = "WindowsSoundRecorder";           License = "WindowsSoundRecorder";           Dependencies = @("Microsoft.UI.Xaml.2.3", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.Xbox.TCUI";                    Match = "Xbox.TCUI";                      License = "Xbox.TCUI";                      Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.XboxGameOverlay";              Match = "XboxGameOverlay";                License = "XboxGameOverlay";                Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.XboxGamingOverlay";            Match = "XboxGamingOverlay";              License = "XboxGamingOverlay";              Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.XboxIdentityProvider";         Match = "XboxIdentityProvider";           License = "XboxIdentityProvider";           Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.XboxSpeechToTextOverlay";      Match = "XboxSpeechToTextOverlay";        License = "XboxSpeechToTextOverlay";        Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.YourPhone";                    Match = "YourPhone";                      License = "YourPhone";                      Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.ZuneVideo";                    Match = "ZuneVideo";                      License = "ZuneVideo";                      Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
						@{ Name = "MicrosoftCorporationII.QuickAssist";     Match = "QuickAssist";                    License = "QuickAssist";                    Dependencies = @(); }
						@{ Name = "MicrosoftWindows.Client.WebExperience";  Match = "WebExperience";                  License = "WebExperience";                  Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.MinecraftEducationEdition";    Match = "MinecraftEducationEdition";      License = "MinecraftEducationEdition";      Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.Whiteboard";                   Match = "Whiteboard";                     License = "Whiteboard";                     Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.RawImageExtension";            Match = "RawImageExtension";              License = "RawImageExtension";              Dependencies = @(); }
					)
				}
				Language = @{
					ISO = @(
						@{
							ISO = "https://software-static.download.prss.microsoft.com/dbazure/988969d5-f34g-4e03-ac9d-1f9786c66749/22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso"
							CRCSHA = @{
								SHA256 = "4bb733eae9c1ebb370e976b3662ef1e707e9e7481ded1dbccae717793a42a0f0"
								SHA512 = "34e2c53ae88226df89128f4e8d870a579b63e54544794266d2fd401e1e7ed88342a22c5f8a48d8305f96ee32bf91f04489824b712b50deaff2351db44d58b03b"
							}
						}
						@{
							ISO = "https://software-download.microsoft.com/download/sg/22000.1.210604-1628.co_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso"
							CRCSHA = @{
								SHA256 = "ab9818870527b9edd5af9ffe6b9c1621f8a0373c02ba73ad033932f6fc139318"
								SHA512 = ""
							}
						}
						@{
							ISO = "mul_windows_11_languages_and_optional_features_x64_dvd_dbe9044b.iso"
							CRCSHA = @{
								SHA256 = "4bb733eae9c1ebb370e976b3662ef1e707e9e7481ded1dbccae717793a42a0f0"
								SHA512 = "34e2c53ae88226df89128f4e8d870a579b63e54544794266d2fd401e1e7ed88342a22c5f8a48d8305f96ee32bf91f04489824b712b50deaff2351db44d58b03b"
							}
						}
						@{
							ISO = "mul_windows_11_languages_and_optional_features_arm64_dvd_7062d03e.iso"
							CRCSHA = @{
								SHA256 = "309e75ba4f8d60f275956421e47d7a7f44633085ac0153575efeda3409a25577"
								SHA512 = "81ff9db234150849373038954694c3821be64a3ac3bdaebd7d8f36396117c4c04f3d7156046113615991d1ba8bf2caf6710653f9aa26d6375fa167866e5f6245"
							}
						}
					)
					Rule = @(
						#region Boot
						@{
							Uid  = "Boot;Boot;Wim;"
							Rule = @(
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "WinPE-Setup_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "WINPE-SETUP-CLIENT_{Lang}.CAB";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
							)
							Repair = @(
								@{ Match = "Microsoft-Windows-Client-Language-Pack_{ARCHC}_{Lang}.cab"; Structure = "LanguagesAndOptionalFeatures"; Path = "setup\sources\{Lang}\cli"; }
							)
						}
						#endregion
		
						#region Install
						@{
							Uid  = "Install;Install;Wim;"
							Rule = @(
								@{ Match = "Microsoft-Windows-LanguageFeatures-Fonts-{DiyLang}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-Client-Language-Pack_{ARCHC}_{Lang}.cab";                                    Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Basic-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";        Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Handwriting-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";  Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-OCR-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";          Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Speech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";       Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-TextToSpeech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab"; Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";      Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-Notepad-System-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";             Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-Notepad-System-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-MediaPlayer-Package-{ARCH}-{Lang}.cab";                                      Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-MediaPlayer-Package-wow64-{Lang}.cab";                                       Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";             Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-Printing-PMCPPC-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";            Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                  Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                       Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                        Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                    Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
								@{ Match = "Microsoft-Windows-InternationalFeatures-{Specific}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
							)
						}
						#endregion
		
						#region WinRE
						@{
							Uid  = "Install;WinRE;Wim;"
							Rule = @(
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-appxdeployment_{Lang}.cab";  Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-appxpackaging_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-storagewmi_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wifi_{Lang}.cab";            Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-windowsupdate_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-rejuv_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-opcservices_{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-hta_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
							)
						}
						#endregion
					)
				}
			}
			#endregion
		)
	}
	@{
		Group   = "Microsoft Windows 10"
		Version = @(
			#region Windows 10
			@{
				GUID        = "d33b848d-ef73-470b-ba0e-8b7f21536ccd"
				Author      = "Yi"
				Copyright   = "FengYi, Inc. All rights reserved."
				Name        = "Microsoft Windows 10"
				Description = ""
				Autopilot   = @{
					Prerequisite = @{
						x64 = @{
							ISO = @{
								Language  = @(
									"19041.1.191206-1406.vb_release_CLIENTLANGPACKDVD_OEM_MULTI.iso"
									"19041.1.191206-1406.vb_release_amd64fre_FOD-PACKAGES_OEM_PT1_amd64fre_MULTI.iso"
								)
								InBoxApps = @(
									"19041.3031.230508-1728.vb_release_svc_prod3_amd64fre_InboxApps.iso"
								)
							}
						}
						x86 = @{
							ISO = @{
								Language  = @(
									"19041.1.191206-1406.vb_release_CLIENTLANGPACKDVD_OEM_MULTI.iso"
									"19041.1.191206-1406.vb_release_x86fre_FOD-PACKAGES_OEM_PT1_x86fre_MULTI.iso"
								)
								InBoxApps = @(
									"19041.3031.230508-1728.vb_release_svc_prod3_amd64fre_InboxApps.iso"
								)
							}
						}
					}
				}
				ISO         = @(
					#region Windows 10 22H2 Business
					#region x64
					@{
						ISO = "en-us_windows_10_business_editions_version_22h2_x64_dvd_8cf17b79.iso"
						CRCSHA = @{
							SHA256 = "18a84e0da1043d7c1d3cf46ee127e8f637d425ad57e115ee862af203fa4932a8"
							SHA512 = "9669bd394fdc7ed335c0728111f6113abb35eab6e557bb072e034e3d1351ad640789e78921e0badbd65aa66a0aec695dd45fd4eabb872e613154142c143f70bc"
						}
					}
					@{
						ISO = "ar-sa_windows_10_business_editions_version_22h2_x64_dvd_07d7f0c7.iso"
						CRCSHA = @{
							SHA256 = "ef1f1817c47cfbc4029eea0b76dfb9920c3d0f5598d692c450febb8def689221"
							SHA512 = "55a3e35d95514dfd621efa82ef867273f1e28240cddd4f3e430313a466dc465d144e25c97d5e0ba31031efc92e66eefdfe671522f98b3392951f95533a3b045a"
						}
					}
					@{
						ISO = "bg-bg_windows_10_business_editions_version_22h2_x64_dvd_5964f8e6.iso"
						CRCSHA = @{
							SHA256 = "86f6e55eb5f7595a019b705df98136bafb153dca1edc46d8e18c24b2c7ebfc10"
							SHA512 = "75b101f46a8463d038e676d4743efb2a6bb8510443614f562f8ff81050dd4390cd46d02a0748353846729c1c41cd2cfc0497a975ff29997b9bec47888fb721d5"
						}
					}
					@{
						ISO = "cs-cz_windows_10_business_editions_version_22h2_x64_dvd_a433331c.iso"
						CRCSHA = @{
							SHA256 = "ec218f4eedb696355f1f587a2b3eb151468bda2246636dce3b4f94bd8b3f0136"
							SHA512 = "0eca643677c6f94ca19704b3f835c9f4fa04a0fd838d156a3b208f1477e4d38af695bb5d6c12c2f7a1f7de916ea426ad2de72b7af6a1bf99b46ad0c38fc67951"
						}
					}
					@{
						ISO = "da-dk_windows_10_business_editions_version_22h2_x64_dvd_62d07c9c.iso"
						CRCSHA = @{
							SHA256 = "b3a648a8bb2c487862789ccfa70a54ffbcaedf8ecbdc74bd280ec1019fbb42b1"
							SHA512 = "f3a1cc307e0ee3b299ebba6327967502984b7192c8ab7eb5d0eab9267574b16b8c1a9714be0b7408f29a27971508e904fd2aebe25e7564abacc3a77c5b7bd17b"
						}
					}
					@{
						ISO = "de-de_windows_10_business_editions_version_22h2_x64_dvd_281ba8e8.iso"
						CRCSHA = @{
							SHA256 = "aa6f12747c96a2cef203bece5a042209c8884892dd70efdba27f86277cbba66d"
							SHA512 = "8e057068436cb69791adced15b4173368ce9d79c3c458a2c62fcb5a3f3ace6cb105e16948c250a64b8165b5c603368c295ea2c3bcf992f0cc0d6c26e8d49ef2f"
						}
					}
					@{
						ISO = "el-gr_windows_10_business_editions_version_22h2_x64_dvd_de0c8eac.iso"
						CRCSHA = @{
							SHA256 = "88a05528342bf6482dac35ed283a48f185d673e8faaf29aace69347e573ef0e3"
							SHA512 = "57013debc901781399562afb15bc1bb3ef724fc9882d318777c6f51d44580e53acc7dd25dcc42373ee57a6331fbfe541e75af76577c14ad907f1c9b98d8e1e24"
						}
					}
					@{
						ISO = "en-gb_windows_10_business_editions_version_22h2_x64_dvd_8680b004.iso"
						CRCSHA = @{
							SHA256 = "4dcc55374b458cfa1379bc9b5d4114cf9f22453f4fb3ab10828233d3a0bba774"
							SHA512 = "e01eedb8a5818a454ea2739c9eeb59227707b51ab789f81f695106be4ee5556fbff662a0a2fd618382390a446126b6fa7eb8b71647e5080b996fa67dda32f299"
						}
					}
					@{
						ISO = "es-es_windows_10_business_editions_version_22h2_x64_dvd_2bc3e71a.iso"
						CRCSHA = @{
							SHA256 = "216200bb43767760f91fd512687e6feb60a85eda6a0a21c7b3c5fb4206df12d6"
							SHA512 = "d8b411f5dad79b77d3fbd6244f198a628b6c30859cec15433530ce1026a4948f03cf4c82918bfd10c06a44897e4f0c41250f72a5e619d011af14b904a3bc0109"
						}
					}
					@{
						ISO = "es-mx_windows_10_business_editions_version_22h2_x64_dvd_04209ebf.iso"
						CRCSHA = @{
							SHA256 = "6c574f9f6409ec2c3b6e830e8b337752c05a82ecea782b6846f4b4d0cf51ce7b"
							SHA512 = "5e439295f5906713d6a8758ce43bd43eb0e02358198112a90d6caf8f3eebc57fccbaa219ee73d66bbcccfac3cccbdb08e2fce2033c02b498b120e072c0feb33f"
						}
					}
					@{
						ISO = "et-ee_windows_10_business_editions_version_22h2_x64_dvd_f343ff4d.iso"
						CRCSHA = @{
							SHA256 = "396cbcf1815a2f1c71e7dc152590927cb0d7ef3c499b19907d39750532f2eb1d"
							SHA512 = "1d35dcfd76e90a3a65d2b96acd9c75bfed83271cdcc7e68ad39639f82612dbbac93f89a327576cb449c0c8f01233ffb82bf73257cbfbc001a2a55579529d7504"
						}
					}
					@{
						ISO = "fi-fi_windows_10_business_editions_version_22h2_x64_dvd_ce3121a7.iso"
						CRCSHA = @{
							SHA256 = "e6b6e5658539397b14dde07ae97b059213ddd9658d007dea7c9bca6d61bffe11"
							SHA512 = "d336666fc1e180460b0dd7fd99e43a1e96612204ffe2bb8c9f6c46e9da293abf5125d69c0eec197b6bbf31c2b29f3e1ae4764ff6b89d9de5ba7c6ff85894d35f"
						}
					}
					@{
						ISO = "fr-ca_windows_10_business_editions_version_22h2_x64_dvd_3d02f972.iso"
						CRCSHA = @{
							SHA256 = "2fb2d7d2a189b00f354fcf00d691ba4b97f10a86128eaa44bec9d94bef4be52e"
							SHA512 = "666bb6bb39065e581210c793af2c55641919a5b7bcb09fa6e39db0fb47ee391190e4837184116dc340b583048c0a61ca6fd2e5cc2638d0612bf535c631f052a5"
						}
					}
					@{
						ISO = "fr-fr_windows_10_business_editions_version_22h2_x64_dvd_9ff381e4.iso"
						CRCSHA = @{
							SHA256 = "6d2e2428953112d164ad9eeac820719063212e5751e006b3b8a28680011d4de2"
							SHA512 = "f75be1f093050544a4a08a24dfd7d8b05010816ce13ab1c7702ad2d32357370d4e07e8d6dc0e5afccf11f480f5014d30a9a879acdc366bf0117ed76d60db8cdb"
						}
					}
					@{
						ISO = "he-il_windows_10_business_editions_version_22h2_x64_dvd_75ef933c.iso"
						CRCSHA = @{
							SHA256 = "d64ce0269fcc87e8b90b9e8666f631547de1206b68e88cbfd51f7a5d197a9121"
							SHA512 = "72aae8c0f57ca0262b8a7d8f3928c3f0cd01ff0356d7c3a99fe71090222d0b4b7656a4232c47902aa4799fed574d63d4b08a5b7e404224140c9bd4d14a8e56c8"
						}
					}
					@{
						ISO = "hr-hr_windows_10_business_editions_version_22h2_x64_dvd_4245c64f.iso"
						CRCSHA = @{
							SHA256 = "98824dc2535f3fd201f33cfca54719ccdb0667a6c14f36eaadc79b2284d963e4"
							SHA512 = "e83b0441402da8cbec872e03d754aad0accc94c2cced63d1b1dc5c67391b33979dcc281ab4839e77bddcd8cf81a881cb8cae0c5815e4fbd41897ab32f07b04b7"
						}
					}
					@{
						ISO = "hu-hu_windows_10_business_editions_version_22h2_x64_dvd_cba17fd9.iso"
						CRCSHA = @{
							SHA256 = "512d27a316d765a30931944ad9b9787453e083f58e342b615d91a358b631ca0f"
							SHA512 = "380b62fbfad0010577ebcd903b7f5f62d3416d9ccd00cd51e6b2fe9391abc23752fd77c204d963471c505dbcf973d7e9daff95c2da6394a92e8341bb91abe3c3"
						}
					}
					@{
						ISO = "it-it_windows_10_business_editions_version_22h2_x64_dvd_f37dc497.iso"
						CRCSHA = @{
							SHA256 = "ae57ebf66bcf4f51ef5586a6693df25bba5405cd08b35cf854362db7ed994a93"
							SHA512 = "b5ebdf5eb7315085e074fcc2ae0844d48f82c8fcadc778debd96f7ebf710ec616741be0218c236b49adc726902a383e09b110af175a9b0a37f02031a7ff63c2a"
						}
					}
					@{
						ISO = "ja-jp_windows_10_business_editions_version_22h2_x64_dvd_e9bb8632.iso"
						CRCSHA = @{
							SHA256 = "34cd0f8a8050219f7236e13a6e27ea4104a9cccd69bfbd3832cbddb5e9bd47bf"
							SHA512 = "6bcb1ea3083ec1e1e9b775fa28a09fdeb9e4bb536747ed66361520005a9c8604ab22779ed3a80c4dbe9ac7b703270231bdb0132940e9d49ab0f2d36020e1bf5d"
						}
					}
					@{
						ISO = "ko-kr_windows_10_business_editions_version_22h2_x64_dvd_d3c79bbb.iso"
						CRCSHA = @{
							SHA256 = "09cc75a6b8992434fd296149e4719498be9684f69f2886a7e70cbcf3ef9b7d58"
							SHA512 = "acbcf80c7b71f99d9f707d470bb4769ef86e8bfcd544401419670aaa0102741bc8b0cc0583fd0b33914554803ac43a5686bd9912d754c0f220ab32e894a31515"
						}
					}
					@{
						ISO = "lt-lt_windows_10_business_editions_version_22h2_x64_dvd_fea35867.iso"
						CRCSHA = @{
							SHA256 = "c8b4edcae72321c812bbfd3358eb4a73e26ddbdbb5b4acddeafc8d89e8b0a9e8"
							SHA512 = "03d2d241bea759a4224aea0c80db156c6c69c9606d88dafb78a1f668125cc89cacf458332fa6fe800077e4a7425aeed19710a65d1c3f6174e7b7e1eee61e1206"
						}
					}
					@{
						ISO = "lv-lv_windows_10_business_editions_version_22h2_x64_dvd_da68052b.iso"
						CRCSHA = @{
							SHA256 = "cc5eaed230bd835acd41e4aaf98f509b72fbdb5800cb9acd1b278431dfb0307c"
							SHA512 = "b43f8199d6e8e36a2639e0bcdd6d88563cf373f5108d595cb58c2710c003951affa20b717f0def75309fe759537c96db776dd3d775641e3c474b2d967a0237a6"
						}
					}
					@{
						ISO = "nb-no_windows_10_business_editions_version_22h2_x64_dvd_afa65ba9.iso"
						CRCSHA = @{
							SHA256 = "583b1abef355530a031a8a2823d0f7b61666facbede1ded2495a16e3c3718225"
							SHA512 = "7b9712b0f4c5b314beca1361c967a373bf67614cee0d1fc193f36b55ef0d91818857c5fc8c092846e50cd0a9ce05f0ffb3d6d083a87de1318ff3aadd0d76f035"
						}
					}
					@{
						ISO = "nl-nl_windows_10_business_editions_version_22h2_x64_dvd_06b3e96d.iso"
						CRCSHA = @{
							SHA256 = "d5242bbe60cdb6eb8df5ce2637e54ada70f0bcba90a88d4dd582e0cfcab7e61b"
							SHA512 = "8c44ea0c1a7cef5a37024b3d1e89b650beb4f9c8c8977c357f21412d6f388b763eb19c4d88fa5b8338aa8a28d7c9f710fa4afea88eed2ee7a3ddc695b23c62c6"
						}
					}
					@{
						ISO = "pl-pl_windows_10_business_editions_version_22h2_x64_dvd_9607c49e.iso"
						CRCSHA = @{
							SHA256 = "902a4c2d6c4cad72c71e2589342042c4ff3e61d6f13eb0d8403713cb970dae55"
							SHA512 = "88bcc3a1c763fd48fb7ab13b6be65b8f3e20c256c218c7534e5a2201949210c79f074b9ddedca7616a9e1f2ac369c902c9690ddaa4cc01cf089ccc1d262ba8ad"
						}
					}
					@{
						ISO = "pt-br_windows_10_business_editions_version_22h2_x64_dvd_211e280d.iso"
						CRCSHA = @{
							SHA256 = "a1bac417dc751884f88e7049abeab605ec40a67b759e60be81aab008ad3de276"
							SHA512 = "96a8414d17c893f54f8859e28abf4519c490c04d6e10fcb353544a805ce2a69eb3058900afe011b4367556296379444f129055e0295a0e9ddc477c07072b594e"
						}
					}
					@{
						ISO = "pt-pt_windows_10_business_editions_version_22h2_x64_dvd_ff5e98ad.iso"
						CRCSHA = @{
							SHA256 = "06fa145ade915f9a78cf774dae11d9d0099c0b96bcbd7f85cd897b4db5fc0076"
							SHA512 = "78389e9a92bbc153e041921c93c6425dddab62d4c047486a60d5ee8d4876a3d0124d69b5c79c7f064675742367e038daec2509aafb031774e74ecdf3442a1e33"
						}
					}
					@{
						ISO = "ro-ro_windows_10_business_editions_version_22h2_x64_dvd_4ec15f6f.iso"
						CRCSHA = @{
							SHA256 = "6f254867f5474c399c92a2e11668c00a479963915c14241866e6f6868e733cd8"
							SHA512 = "ac370544c50ca4b9506e56c102cfdf12a6911cc5a11ce5890b58a51bfb634450e631b318b1e018445470f79821e782582d152dde208484e4da0514e2f873f7e3"
						}
					}
					@{
						ISO = "ru-ru_windows_10_business_editions_version_22h2_x64_dvd_61849fe8.iso"
						CRCSHA = @{
							SHA256 = "26d9a70103b825b5b063b61791ec40ea4c39253bdd607816cc2be14b54bc855e"
							SHA512 = "e2293aec1c8ea8543ee31ce6e73fbefb42d55e65107a399e05d465060c80d7df392d678c3809fbed429b355d4cdcdcb2ea9fa799e68812e489b832f2d1735974"
						}
					}
					@{
						ISO = "sk-sk_windows_10_business_editions_version_22h2_x64_dvd_d64cc104.iso"
						CRCSHA = @{
							SHA256 = "364c69234f06c07df6d6c04913771bd9f9ed7ad51258e964c140dd95c6b19cf0"
							SHA512 = "83d714cbb6cd07f0f83ae84b21eff15a277bcc77f7a9b6b325b733d05c525288e70497bb7cd823673c6c243fa2059cb991491bbdd86d9c9c3d5898539e4c9dff"
						}
					}
					@{
						ISO = "sl-si_windows_10_business_editions_version_22h2_x64_dvd_d3ae51fe.iso"
						CRCSHA = @{
							SHA256 = "06497ed107a72ba60b76e7dd8557f69361fc4ca98d2649d3fbd9cf54e2b065bc"
							SHA512 = "dd90c32889009df25c4ad57dcf62a7418541d2d4dafe7e5d5e0e21463a8aaa15846e599dad36cde2bc2a3c9224fa723236cd0748550b15ebda3e33c9cd588846"
						}
					}
					@{
						ISO = "sr-latn-rs_windows_10_business_editions_version_22h2_x64_dvd_efda1218.iso"
						CRCSHA = @{
							SHA256 = "f7aefd48d8ac8e44925677e71b5e22a3a465f94909567f75083d921e78acea00"
							SHA512 = "d042a998df79426f6dd5040cfa1f9f5e6ca44b5428a8410255700971cf46b63b761355541108896781a4102ba699bdffb0a5306a0faf1cf3b3cfee7896b1aa18"
						}
					}
					@{
						ISO = "sv-se_windows_10_business_editions_version_22h2_x64_dvd_42c9df74.iso"
						CRCSHA = @{
							SHA256 = "b6a312444ca61a1d5d7c1f5e82a9ecc08a486bbf9d11f99167d823c279ecb745"
							SHA512 = "186a9d6bf3a9991094255ba568dae1c5145a9b9cb7cdaeb40dd10d9fb1e363c67f9b97072857a6e378b49dd5a8aa679d6a39805b4ae3f12d2d4aa33c764919a6"
						}
					}
					@{
						ISO = "th-th_windows_10_business_editions_version_22h2_x64_dvd_693a96de.iso"
						CRCSHA = @{
							SHA256 = "430022610630d626f3fd490ec3dde8e9a19ee3c059a3c7813cc95fc596579ea2"
							SHA512 = "9607676c0431fa9fec8639864b83c87914adb1278eb02737b1b060b44109f5bae06b94a1fdf0889be45bc22b7859038302894f898efdfd5b49df050722c1cbcf"
						}
					}
					@{
						ISO = "tr-tr_windows_10_business_editions_version_22h2_x64_dvd_a03e35b1.iso"
						CRCSHA = @{
							SHA256 = "bd532956060c3f9614d11f9de1ec159ca80d7869eb49de65469c7df9fc227265"
							SHA512 = "fcf1228bcfc34a580b1d7de0932f1971db07a3bbc36a10ab9266fd1bc48b9b81f50c7d304dad1a8b159e1cb6af06c0b0cc985c7c0b679acffe45dce9acde9ff6"
						}
					}
					@{
						ISO = "uk-ua_windows_10_business_editions_version_22h2_x64_dvd_0ab6011e.iso"
						CRCSHA = @{
							SHA256 = "7f22d5a85f46ddc883e8d7950a50dbb191845674ad395ac60823a57ebcc3f9dd"
							SHA512 = "11fcc29907449f424d55e9a6b6a2572fd0660bd2b363663b10a436268e972009dfbd0fa38b166ae9472700a4db6b68ff57306ed53e8ba9259f7fe903e388c74a"
						}
					}
					@{
						ISO = "zh-tw_windows_10_business_editions_version_22h2_x64_dvd_92264bde.iso"
						CRCSHA = @{
							SHA256 = "91c5b86e6ff0d0d9f3c29e26eb60c10ca379638ae3082c456154d8ab23334414"
							SHA512 = "7af492a213bd2186616433787104071f7de84ad01d2df2e0198891def86e17fd96579e37d9fed121e29735d6d6af4cf2f8081b86c43db8fc1a3238fcab8bc1cc"
						}
					}
					#endregion
		
					#region x86
					@{
						ISO = "en-us_windows_10_business_editions_version_22h2_x86_dvd_186a68c3.iso"
						CRCSHA = @{
							SHA256 = "9319bdd9e09bef723e09536519a082618caf7aa8dc1a4135520d7a5a8a8893a4"
							SHA512 = "c0f260b9b00053ee8b714397e1f4e10b194ac7a300e46962feebbcc71b436dd90aded93ec6d87ab5151a15efd5538b40d6e91d885d7aeb83bbeb8cbc798fe82a"
						}
					}
					@{
						ISO = "ar-sa_windows_10_business_editions_version_22h2_x86_dvd_e502917f.iso"
						CRCSHA = @{
							SHA256 = "909fd8cf5ed99430c22c129a07dc0cdf01f4675691a5e09a38d56b69db018514"
							SHA512 = "94bc8e75869aafb0e743bf59f8d1537b4bc02f680ea4551d6c22faa849522b8c93f4e24378a6adfff2d20f44409a1df4ccee8061982ccc5c4ec40db8c947ed52"
						}
					}
					@{
						ISO = "bg-bg_windows_10_business_editions_version_22h2_x86_dvd_97ad32c3.iso"
						CRCSHA = @{
							SHA256 = "839f60b6d4969bbf529fdada9a022aee20c8759294f0f62d937e8bd842010c9d"
							SHA512 = "b22c8ac1d10b3bf0b1964de39d2a3bd582cfac9f439736e24d56461cd18d15230b61468d8d618d18aa9abca8a7d4e93e334fb09246e8a9e415d7cd71c399e592"
						}
					}
					@{
						ISO = "cs-cz_windows_10_business_editions_version_22h2_x86_dvd_bfc8d4b4.iso"
						CRCSHA = @{
							SHA256 = "7191686b8437c212d14ae008c8fc36e42cc5cb3e7024377b06526e8ac1059e1d"
							SHA512 = "9cc855dd00502deec95f233f2bbc291a03be1790c33612e1948d97bb4928ae79d8f8a3eec1b59db7fa51dac5356be3bed60e75ea3a03555c85d4b44d337e28e0"
						}
					}
					@{
						ISO = "da-dk_windows_10_business_editions_version_22h2_x86_dvd_2238356a.iso"
						CRCSHA = @{
							SHA256 = "77424b1a21c28ba7f6b05afb5d0ed1ffd1cbbd0be097de72b14678c569a5a5e1"
							SHA512 = "c27582d7634da14dc97c5b97e75a0771e99e5a58cefdd0c4dce16df1d075891b2120c81498535b0d9865efa7bf3df12d624f0cb6b703b6730f628afadb71855b"
						}
					}
					@{
						ISO = "de-de_windows_10_business_editions_version_22h2_x86_dvd_a0ddc55c.iso"
						CRCSHA = @{
							SHA256 = "aadbd363396b8b30330c77fc809818566fedd21f9703a3004f0e2dc358dfd8f3"
							SHA512 = "0c421fc10123941ad655cb64cd6fb649be071c214e36e84ac896fc435da482b3f6cfeeb963bf20141bf8ad422a624779d2c93477e9de18c1ab932f83125e3861"
						}
					}
					@{
						ISO = "el-gr_windows_10_business_editions_version_22h2_x86_dvd_04516eda.iso"
						CRCSHA = @{
							SHA256 = "44c45750f5fe4c0c2c4bf3bad5f1227f24fb2119cf539df4cd8d858ee7160e39"
							SHA512 = "603ca1e3ee1acc6c17e7bfabe219253362a9203ab675059f89417c8ab07b0c53f91ddbe4556e6b041bbf917e08af3e64c60574eb87f298c0e4c771975ba8ff41"
						}
					}
					@{
						ISO = "en-gb_windows_10_business_editions_version_22h2_x86_dvd_6ecb0fc8.iso"
						CRCSHA = @{
							SHA256 = "ef69ad84efc49ed66708357af7f02604f71d1dcf0e90d702228bc5b08b1e6e2a"
							SHA512 = "57b3cd503e079e97c40696db87b738a9dddc0bb86c70a92caa697a8a9bfd362138f9c74af1ca4337a9ded91f7ce9cb98b7a3be4da09ebd47b5a61a53725d001b"
						}
					}
					@{
						ISO = "es-es_windows_10_business_editions_version_22h2_x86_dvd_25db6266.iso"
						CRCSHA = @{
							SHA256 = "c5e1e270614ca7c41323fe7c07ea02523b84b6d82577f94c0f9487f89095601a"
							SHA512 = "074ecf86540fed2e385357d39e8ac2a91b244b8f9c624fc36f143a215fb291dee59c7a1705f99c2b9eb0b45c01424b8f97b31e233c4be9e773f1d03d34358753"
						}
					}
					@{
						ISO = "es-mx_windows_10_business_editions_version_22h2_x86_dvd_5f41ec2c.iso"
						CRCSHA = @{
							SHA256 = "d65daa0430870d6d410392834699744947f2a80239a326244934bd60d7211c72"
							SHA512 = "a4f676eaf89570c1ef44fe7de16f4cca21dca454dc41775755a00f35b6b477c12764bf7c03322cf7db582049bdfcd4ab9fdd075b86b1c54ac0540e8913524cc8"
						}
					}
					@{
						ISO = "et-ee_windows_10_business_editions_version_22h2_x86_dvd_9f8ef6f0.iso"
						CRCSHA = @{
							SHA256 = "5f96d55debce065728f1c94e87a045784edc6f1207bc02a33695ab7c0e5bf988"
							SHA512 = "9d65fd6c1da059b5dfe4416a8b82f34d6c8bd52fc5e6b3f8df743c778423a5fb0fefae39bdd805bd48add585342a70aa0974bf37bc971eec157424ecf005ee0f"
						}
					}
					@{
						ISO = "fi-fi_windows_10_business_editions_version_22h2_x86_dvd_fa0fb8b5.iso"
						CRCSHA = @{
							SHA256 = "257706fc2c95168629fb773bd461ef5fcb50480d05ca6310d7dacdf4d24de884"
							SHA512 = "7a2eeb38b763c71c08dd51e97dc8c25e69eb8a0e51ea280424ece8ab7be750ee2feead5c6d61216f7b1662b2554b0842fba3aa35133746b0ef9a4057e4e9b663"
						}
					}
					@{
						ISO = "fr-ca_windows_10_business_editions_version_22h2_x86_dvd_6111a263.iso"
						CRCSHA = @{
							SHA256 = "ac3a8120a9d4bc4631b25e6ed5da65422f881ca75d4638004bd5730eb5c79b26"
							SHA512 = "59f5635c6c8be397d11ac32bba9941bb17c26843aa21c258da4d2447f37064e635fd16b670f88597df9b232676dad1d3a127ed8676b3635705f6d9814584da64"
						}
					}
					@{
						ISO = "fr-fr_windows_10_business_editions_version_22h2_x86_dvd_2c46ee44.iso"
						CRCSHA = @{
							SHA256 = "f0bad3a248ffa5f01560550181ee48abf9b2fdfc0a4f605d5761a3dbeed0ea6d"
							SHA512 = "fe371ec0dce60cb0f92fe1f2c3682b00875d30abf3a330349d4daf2ba461dd304a39e55d9f4930a1d02bbb5ab2e92187c9a5fed47ff9175993c5aa348321f186"
						}
					}
					@{
						ISO = "he-il_windows_10_business_editions_version_22h2_x86_dvd_e30b7eaf.iso"
						CRCSHA = @{
							SHA256 = "8a8b3f20a856a29abf11bae05d77fd0986a530c8d9cbcf3b0120ed8211173fef"
							SHA512 = "0f648d12897e56b9d69a5485ddf7cfcb8b933b4e137f5f7eebf9c96c033baff999f47256b0d210661f05c11a20d16ad469a2f3b53c1bc8719851625c36ff3916"
						}
					}
					@{
						ISO = "hr-hr_windows_10_business_editions_version_22h2_x86_dvd_be7269c8.iso"
						CRCSHA = @{
							SHA256 = "ff050d4178b8f25ba9be97d5a6bc1e1f4858b0349918864717d3e3a9ade9f390"
							SHA512 = "6502987e9339bd0ca9ca7fed4d9b65f27f9f842828cb3f084b48867d8255522e3f3fdd6d282d28db4c1983a9b639c1960ff2a233c2080e7e236824afb4a33b1c"
						}
					}
					@{
						ISO = "hu-hu_windows_10_business_editions_version_22h2_x86_dvd_2b47c933.iso"
						CRCSHA = @{
							SHA256 = "78b6c11f997920e5f1ac313eb2a5562a8069c9da6cb0f663882430eeb684d1aa"
							SHA512 = "e03399ad7b8ef399c449d1ef7924703bce9b57cb3bc05678f99208347d5738b7e238d17f6458dd099e31fe53a89f4d2fc51c55b09bcfae08bc94356a7f10de2f"
						}
					}
					@{
						ISO = "it-it_windows_10_business_editions_version_22h2_x86_dvd_f1d63b3e.iso"
						CRCSHA = @{
							SHA256 = "0e86f62e89b1c120d3cbc059103646933b9a21f9062b12b30f114e94518b886a"
							SHA512 = "5c1525d5755d539b0451bfbf58eb75d3ce84a2f4f557fabeb19c32448398d5c55977c061d508c48d9acb5fce85e59b27a8d7211b414dafa8b3c9fc43339db084"
						}
					}
					@{
						ISO = "ja-jp_windows_10_business_editions_version_22h2_x86_dvd_8f3a3a36.iso"
						CRCSHA = @{
							SHA256 = "70dd111e72b5fd505db2c7882e218a34ae1fc0234aee35129d6138d29109117d"
							SHA512 = "d2668bc625064800db49e22264c1114f1e7ae997b19740280d8df85289dbbddd72d771ce4479367327ddc576461263e36546ef6c44b4c550bdf352010f0586f0"
						}
					}
					@{
						ISO = "ko-kr_windows_10_business_editions_version_22h2_x86_dvd_8f44359f.iso"
						CRCSHA = @{
							SHA256 = "3b1b75186d2a124f4531dadbdeab3dbfa74e96e8a97cc7cf148c22f000aca529"
							SHA512 = "948c932c21eee1b3d6b61c20783de4326b08cc49274461333a48ee6875ef416953fa0efeb4d2a6f8b3feb937e6b7845b85e6605f86e82a01af2f9e20fd3f6e4b"
						}
					}
					@{
						ISO = "lt-lt_windows_10_business_editions_version_22h2_x86_dvd_927665cf.iso"
						CRCSHA = @{
							SHA256 = "59957861060c01c0bf17869cec7c23324a5f422d467103068b8ebf3b37f3ceb2"
							SHA512 = "efc5578f96ca5de9af77fd442566d234786d1f0ba6b798c933ebba9430ad6d61b50e1babdb7fb1e84f2a2f71271b749e8bde09ef42d6811acbd81b9f9374003f"
						}
					}
					@{
						ISO = "lv-lv_windows_10_business_editions_version_22h2_x86_dvd_9a87830b.iso"
						CRCSHA = @{
							SHA256 = "d0b1906c5bb94ac751ef59d4ac815b99f523d120f777f7238ed387612fe0cbf9"
							SHA512 = "f5f4b94536f045d14a33c5430a3bff51bd82a3997ab5f2f03cdf6b1ef3008e3cf42434bd1ccb5e817203a85af798b343b11bdabf155245e7c54910f46efa4ab4"
						}
					}
					@{
						ISO = "nb-no_windows_10_business_editions_version_22h2_x86_dvd_69a59010.iso"
						CRCSHA = @{
							SHA256 = "822e6e4cfe2cb42049b7f718a9429a5f15ad40c3e80b7c13a7ae6a88debb761c"
							SHA512 = "9c651587c55040a39f920c0e7e7503533780511e75bbd744d0e3de3111af5644d569c5af1105100c10ba7cb40a26b12fea05205f088bb67e87dc96e5379db15a"
						}
					}
					@{
						ISO = "nl-nl_windows_10_business_editions_version_22h2_x86_dvd_28b667a6.iso"
						CRCSHA = @{
							SHA256 = "d54b4178672bcabb2b8b6b7cc11736b8e9bcbda87d7db40b78cd5c246e7fd15d"
							SHA512 = "cfee5eb22ed2ade73377bd2b5cca36253ab6798ba5ce0135aa0355ac7d41f7b18299059c62c0301052771f73b7af533956486741f0b538ceaf578d4f3111b1d2"
						}
					}
					@{
						ISO = "pl-pl_windows_10_business_editions_version_22h2_x86_dvd_cdb1a373.iso"
						CRCSHA = @{
							SHA256 = "ef5bec224d87c4ac97378955b0d0386446886533b3e928bc94c4d313afc28fbd"
							SHA512 = "3e22587e3e6cb0361235bca3013c161fc637917b9e625cdd5dd2161bba98942c66fa463acd26d06c09ff7a9782b7a570fcbe6798a692fccd786cac553cf40004"
						}
					}
					@{
						ISO = "pt-br_windows_10_business_editions_version_22h2_x86_dvd_1c5b36a3.iso"
						CRCSHA = @{
							SHA256 = "a96229860be983fd8e4ce1846a38e22f007f0a55e7b2150aec34cd00dd5ba264"
							SHA512 = "b457a9468feae08e09a002382aa7a2ad39e5556f739346306c29ca9730ed34debf00109f5347d48a19b5516d3107714748bb2460a863d3abb615a736bcd35e60"
						}
					}
					@{
						ISO = "pt-pt_windows_10_business_editions_version_22h2_x86_dvd_0dcd2dd0.iso"
						CRCSHA = @{
							SHA256 = "59523fecd79dfe395df0831a546ddcdb4e65dc3da6c7023ad0bd05f6cd79816c"
							SHA512 = "1bfb4b3eab4305addce6aa4f4e823b892fcec98ad14674dfd5f6535d00cf1867968c35556d075cba85bf4888309a356d49f55b1a2d912ab52242d6dfab88bbaf"
						}
					}
					@{
						ISO = "ro-ro_windows_10_business_editions_version_22h2_x86_dvd_d7fe9f20.iso"
						CRCSHA = @{
							SHA256 = "85d327e1823ebc952e70abc5d42fab04c62927e6d0911d6eb2e472a7855c7bfa"
							SHA512 = "716ded9e02527e9307c29d5cc79625a2aa0d3a973e821dc39d8b8be5182ec46f386d32397bacf9955bad2a31cc4faee056000bebf96b3d28cf98361c64bcfe67"
						}
					}
					@{
						ISO = "ru-ru_windows_10_business_editions_version_22h2_x86_dvd_1f394559.iso"
						CRCSHA = @{
							SHA256 = "524d5b813b04a5588eb0876f811fc76cec013268eab2ae66aac7c148a7a8aa9f"
							SHA512 = "b0bd881790eb13c1698450d744b394abbc8769e4ba1e9274a0209035c85edde8f884cf2ec8569c8fa384682656f7b1c2c353d6131efb1f7d3123110df4d9d240"
						}
					}
					@{
						ISO = "sk-sk_windows_10_business_editions_version_22h2_x86_dvd_cca13bb2.iso"
						CRCSHA = @{
							SHA256 = "29f7ddc4ac04b34187cc7db59e1bf9602d35568ecc1ceb45f3dad7daf3e4164b"
							SHA512 = "68fab8fba4f2d78722674ec00e73f8ee047ded2f97a3a83c8f547fa41d4e008485f56f75053c52df1ea3ae529fed213b6ff156aa8a8108380340f5f838145ea7"
						}
					}
					@{
						ISO = "sl-si_windows_10_business_editions_version_22h2_x86_dvd_e47c391f.iso"
						CRCSHA = @{
							SHA256 = "a71797627de67a293a93b4a34737368fb64dcc4c545fdaa279ae8dcdd8ed3a78"
							SHA512 = "2fc4c5a14fba7de156e21629584eb5f8f42273543f0d0ca1825b70c51e2ececd1555451c1c56eeb4d7546da6395c90de24f71596d74549bb7ab0ab41eca5c0cc"
						}
					}
					@{
						ISO = "sr-latn-rs_windows_10_business_editions_version_22h2_x86_dvd_5648e8da.iso"
						CRCSHA = @{
							SHA256 = "016144f35f3d3ee9673f9a37f3eb728d4d602f761f183edf52f795d3518401da"
							SHA512 = "c59dd16456c8f0eacb66ca58f3b021763b7e88c62a0395965264b2748fc60b9f0b137f1149ecd50caee6891a8f5730cc46280a2e7a88b685a33e1219f159bb6c"
						}
					}
					@{
						ISO = "sv-se_windows_10_business_editions_version_22h2_x86_dvd_956ecfb4.iso"
						CRCSHA = @{
							SHA256 = "165ceeb785a727fdeac23ea70cbe4af372779a77721e2537ff896628ee8ee575"
							SHA512 = "5f2b1cea3b550a1fa91b9f400d5eaa1a9050e25863ff9f556396517500ecf608b2df13b821e53ce37862a0fda72c5bd07edadd415e7f79e67d8d16c6bd376422"
						}
					}
					@{
						ISO = "th-th_windows_10_business_editions_version_22h2_x86_dvd_e2006a54.iso"
						CRCSHA = @{
							SHA256 = "46abfbe38edce957005d4963f4a669dfa73e0e5cc8ce773e111a618c01c0b3ea"
							SHA512 = "edaff3e6abc01f0dc40581f81bf03150f34c91fd2509ba9b31bcf00678e35c606adf82a5d0f979dca866fe9663ad9bdf27083d17ec9b19129aaed53d8323a36c"
						}
					}
					@{
						ISO = "tr-tr_windows_10_business_editions_version_22h2_x86_dvd_9d5eab1c.iso"
						CRCSHA = @{
							SHA256 = "d496998c1ee7fc1cdd87bfefd5687ef2346dbd7d0341360e04dcfe0fabc60ff1"
							SHA512 = "3b5c45ef82186aeaef25822223fb6f4d0be68d771ab1e541b2466b7ee10a642ac5e18d44baaadf186df494209e0f8a6493bb1a9f1eb5a668b3927b3cef7ccd20"
						}
					}
					@{
						ISO = "uk-ua_windows_10_business_editions_version_22h2_x86_dvd_e0d916a8.iso"
						CRCSHA = @{
							SHA256 = "b2ae83a4edb7884bf79e5b443a65798e68750502692301c589a9f54fa68cca8b"
							SHA512 = "47b88e7c557d8713e5c483ba6a74569943f9c71fe5e3672e212c3cf631e3f0a2305ec0d654d127e65d6a2fb33fa5e5bfef4a6261b26c01ad0bc29de46c543d4e"
						}
					}
					@{
						ISO = "zh-cn_windows_10_business_editions_version_22h2_x86_dvd_d08b6e72.iso"
						CRCSHA = @{
							SHA256 = "1762cbcbace39bf63733723b55af86cd68b4cb771e90a8504a1867e000a38dd0"
							SHA512 = "865d98d03ef474b1d38378754a63fe9ce39a660b13ee48eb7c5605f0e50bbe90f94cd1bbbbc429931e55f858fe43610ba43c400e05309fbfa185efb1b83d3f50"
						}
					}
					@{
						ISO = "zh-tw_windows_10_business_editions_version_22h2_x86_dvd_9a120b82.iso"
						CRCSHA = @{
							SHA256 = "4ba2cc10700eaafa22d6d078fc837fe13fae6c4c2a379a67f95d4d63b374a622"
							SHA512 = "9ffa23cde91df0b8bb500735b3f144fc8a17f5d6cb9bff1910a968ee55fa0d28cf7d8e798db5bb6fdf3cfe5fd02a5452e959f9e5c54118f7c6bc8974329f9ef4"
						}
					}
					#endregion
		
					#region Windows 10 22H2 Consumer
					#region x64
					@{
						ISO = "en-us_windows_10_consumer_editions_version_22h2_x64_dvd_8da72ab3.iso"
						CRCSHA = @{
							SHA256 = "f41ba37aa02dcb552dc61cef5c644e55b5d35a8ebdfac346e70f80321343b506"
							SHA512 = "090b7cf99fe6463eb406ea7912aa7005764860976f45e1d069031e1c8cda1fa2c9a44090767906d74803ecd33143b8ab0879e08f9ba95072d46e7e637eddc4f8"
						}
					}
					@{
						ISO = "ar-sa_windows_10_consumer_editions_version_22h2_x64_dvd_100112ce.iso"
						CRCSHA = @{
							SHA256 = "62534d3448fa8fe66d12f73a8d87b1210e09255cab605cf920ac4bd6239dca14"
							SHA512 = "de562792857b04e98bd86a57b9aaad83f2eb477b9751457cb0a222acd618a87a74b31129a1416e616ece22cade6efdeff78447e56d88020f3f3c9a76391dbf6f"
						}
					}
					@{
						ISO = "bg-bg_windows_10_consumer_editions_version_22h2_x64_dvd_c8b403fe.iso"
						CRCSHA = @{
							SHA256 = "b6d76e275ebed4ac66e5077936603b420574d1ed553a6b9ed5e889ca0c0cb1b1"
							SHA512 = "134f960be7aa306cfa3f4463d92798e9a53a57a626a3584cf97ee67b60d1e518535737fc9e2d321ed2359776fd702a5c99b726efa04e0a7cfb4b20f740921f0e"
						}
					}
					@{
						ISO = "cs-cz_windows_10_consumer_editions_version_22h2_x64_dvd_791ba3ca.iso"
						CRCSHA = @{
							SHA256 = "540ff7b19157e9c2afc6353b8fffa2f4e129b9cd3f32476fd10d19545ee88366"
							SHA512 = "37554e7a645f45193fb5a8b7cd9ba8926061c4e3d704f94cd052f1059a659b1fc24302c24edd241436fcb591244e3f648ea7b556213e5a4b896cbc3aec4aeefa"
						}
					}
					@{
						ISO = "da-dk_windows_10_consumer_editions_version_22h2_x64_dvd_1027e8c9.iso"
						CRCSHA = @{
							SHA256 = "6c1a94bef71497df45ee2d87b90d96d834d22329445d6e55c6ed9eec75af0a26"
							SHA512 = "773fa949ffd243e135e8f0fab302527312396745914ebc549d3ebc173cc6864cf4c6dbc469a587392ebd7830d23d514a73bf2e93841ec9c02827351399a3d803"
						}
					}
					@{
						ISO = "de-de_windows_10_consumer_editions_version_22h2_x64_dvd_ac60ae62.iso"
						CRCSHA = @{
							SHA256 = "fd054604370c19149ccef7cdddbb3009d5f65a59f8071e52e46ed3f98f05aa56"
							SHA512 = "cf091d7167e348bb283ae837daa05af6b7dbee8ca47f0f2a953ac9800685711ba5c81280a0e88e594e304f1b1205141b1b09a50add0b626f2a89a1e2450477f1"
						}
					}
					@{
						ISO = "el-gr_windows_10_consumer_editions_version_22h2_x64_dvd_cc652817.iso"
						CRCSHA = @{
							SHA256 = "63f6af02ed071141e4e8ac3c89e87f7ca656374e5e22da1d889bc9d757faafee"
							SHA512 = "2893f7c074f83b73a9ec536b5a3de1c1865a22e88f534424ff10b20c6121cd887edd6e8d7cde56b89ab07210fc0059ce3b66e798b5d646b6f9f9fcaa65eeed0d"
						}
					}
					@{
						ISO = "en-gb_windows_10_consumer_editions_version_22h2_x64_dvd_e7c183b4.iso"
						CRCSHA = @{
							SHA256 = "3ac5522f9db9f4f432a1aade69fef268c8c0b5fd3f22d3a6987719752f8a7108"
							SHA512 = "9645e6c3cc880736caabbf0ca6326fa48dc787de0f8a2688772ebf174b753bb0f7b0dbe4c54f7b0c088b6f7f9c4992ec45525f03728e2a10b0bc5de7d83e47f8"
						}
					}
					@{
						ISO = "es-es_windows_10_consumer_editions_version_22h2_x64_dvd_02766bf0.iso"
						CRCSHA = @{
							SHA256 = "254eb069827e48e76168e30676928bd6c68105101dc8db4ae6149f9a8b4ef17d"
							SHA512 = "80a126648c18135e08ec7b72964d5b58e00ea9f22e20c34c3aee771f50385bce2cf8455c67f57cc4cde860074fcf5007a7c9d300b82a5b3c9b1c3d258cebea97"
						}
					}
					@{
						ISO = "es-mx_windows_10_consumer_editions_version_22h2_x64_dvd_ba8d02a7.iso"
						CRCSHA = @{
							SHA256 = "35377cbdcc5a91a2399bc12fef52a189bccf35aa34faa039ce3a21455cd65743"
							SHA512 = "d50a6c898658dcad91b93f72abe0fcade85193e9f4439e0ef876455260ae5af004137d9590907fec9822d17769a6de1599bc7b91364b1280268053918c0f67f5"
						}
					}
					@{
						ISO = "et-ee_windows_10_consumer_editions_version_22h2_x64_dvd_0f5f0733.iso"
						CRCSHA = @{
							SHA256 = "84f883452a43d879b1ef9a5e9b0d28d8ba98e523bb574712a2c8ea62ac058b12"
							SHA512 = "13e9dc333574a54214f28c35e5d78a429465b45349eb2e06edccd4aea0b475c247c6b8a1b46b304d7960e098bfa11f70a44d58b3c928ecdab8d3a42940c1954e"
						}
					}
					@{
						ISO = "fi-fi_windows_10_consumer_editions_version_22h2_x64_dvd_c4ae7099.iso"
						CRCSHA = @{
							SHA256 = "999f0241689a0aae87756dbec8aa9f2c950acbaa01dd1e3db5c3810fdf79906a"
							SHA512 = "112c85e1e1da1cf5ee7a566063da00a19c9a211d0f9d3966d132963c2701382f2a310f2b0d96a7fb1a764d3e400a4d0bcba85e9da47050237bdb7af4f87eed06"
						}
					}
					@{
						ISO = "fr-ca_windows_10_consumer_editions_version_22h2_x64_dvd_9578e27b.iso"
						CRCSHA = @{
							SHA256 = "69bbf794e3c1dc938ad580a57c252e028840893a974904a7641183a6c27644a9"
							SHA512 = "aedbc7e9c79ee0d96e26fcaa76af9811eb123734f4041d13f5049dee92327cf02465723e3b86c38f07026b6904aab2856113ea4735f8c2957feff683a27afc19"
						}
					}
					@{
						ISO = "fr-fr_windows_10_consumer_editions_version_22h2_x64_dvd_e3797c5f.iso"
						CRCSHA = @{
							SHA256 = "863673571c318badf21a0e4b8be9d0f80b6213e217a20a4b9893400e0781ac3c"
							SHA512 = "db1a778c22abae603c1bbc1e2cab89731dbc658150d40f87f9a27a4f556f54bbfe4a8bcc5786e0240edea571df99e981b47e078a0257c99332aefb1e4fec0118"
						}
					}
					@{
						ISO = "he-il_windows_10_consumer_editions_version_22h2_x64_dvd_5fbeaa28.iso"
						CRCSHA = @{
							SHA256 = "94e533963b16a90ccda68b126b6d7d9516094c0716a554613d6a323343e9fe09"
							SHA512 = "6544db2e8fd7ad8817856826cd0cbc6a6a79c45aa84aae710e714f51a9893165eb71414a09863170b15b69a74add0c11b1d35fbbdf7c777204d7bc053e0eaec7"
						}
					}
					@{
						ISO = "hr-hr_windows_10_consumer_editions_version_22h2_x64_dvd_df6ad8d5.iso"
						CRCSHA = @{
							SHA256 = "24108f01d1ef4872d09c37c7b55fdeb0ef23956c64443af43d71ab5cec9e7db7"
							SHA512 = "74aedcd635129c42fe3daf50b89499645e2e4a5ed240378461c80d7bb2c004db17613634aeb65d105ce822ca7d00a5660e761b587c83c669229370d5643812c3"
						}
					}
					@{
						ISO = "hu-hu_windows_10_consumer_editions_version_22h2_x64_dvd_e4c6cd22.iso"
						CRCSHA = @{
							SHA256 = "01274a5f721789b1c0ae9fcc9c3dc0e02c36cd2d901befb3d927e405cb90386d"
							SHA512 = "d68f2e17001b32c690c26ce347cb993e4584b6e2f54a460629ecf906533a8af9c2b33c0a1475fb959a3cf2b588f47ba4527365510a7651e4ffccb6b92a456aba"
						}
					}
					@{
						ISO = "it-it_windows_10_consumer_editions_version_22h2_x64_dvd_75ec571c.iso"
						CRCSHA = @{
							SHA256 = "3a7830f3a168777d55b02c21833aeaa3c82c194cc36cd095acf4cd757208e6d9"
							SHA512 = "41983e620909007e145df65f1872c2934ee661403b938fcb2409e3c28bdbb5c13e675c24c459537367dfe1e5bb4cc2bd6781a5514e4815ecd68e1e25bed56f56"
						}
					}
					@{
						ISO = "ja-jp_windows_10_consumer_editions_version_22h2_x64_dvd_ea707ee0.iso"
						CRCSHA = @{
							SHA256 = "7f548e67adaeeeecb8039c783263e8b7184692b2498ed206ed3718c5694bfe31"
							SHA512 = "0a3d1e0d6f494e1e3c9711d2c3f72aa634d7dc999794a5a81fa5972eebd1bb4b1aebf6a7311b0a00bd2026afc8d25698762f65e8d10205b5a4673ad3e4e1244a"
						}
					}
					@{
						ISO = "ko-kr_windows_10_consumer_editions_version_22h2_x64_dvd_63260ce7.iso"
						CRCSHA = @{
							SHA256 = "a9e7ba177ef9e30c1df66f12079c268158e823bab5a65733c7df1923f0e25bcd"
							SHA512 = "3c5d952b2979cc7932fbc14a7e5064455b0356c25c0c55b6a86c2d4252258b4ecd49eddb79a2e00fc7e0102d179855ea42f5fb7a3049f437a0665beb8d406418"
						}
					}
					@{
						ISO = "lt-lt_windows_10_consumer_editions_version_22h2_x64_dvd_49290003.iso"
						CRCSHA = @{
							SHA256 = "a45f5d7b3ba4a93959a94da7636c467c7ce3ac27dfcecc0b395820f6cdfeda01"
							SHA512 = "28918c2171312e88a5abaa37d79f445dd411ca7b6a31c66e8846061996c4bf4def130ef9d0a479ff2be1fe6e615644b42269c188ec60460248fccb2fad6e980e"
						}
					}
					@{
						ISO = "lv-lv_windows_10_consumer_editions_version_22h2_x64_dvd_f751d9fa.iso"
						CRCSHA = @{
							SHA256 = "8813727ae4cfb08fe6886c5470790df919241d6b1ea2ae35e07a7f16fca5bd6a"
							SHA512 = "ace8828a77285b0f5dfb7ecaf0baa91be6c8632ef20be783ee307579f80383ce24fe9ade5b16a6c2227a9e0c44e0e1a01bbe878ed4c432f329bda1f9c4f1fe28"
						}
					}
					@{
						ISO = "nb-no_windows_10_consumer_editions_version_22h2_x64_dvd_0d2191bb.iso"
						CRCSHA = @{
							SHA256 = "5fd6684609cb95cfac861b24401da61319806fe64a443c58c9bead39224658c5"
							SHA512 = "187f2663f154f27594fad4f6dfe3f73c8872953b12ebb095d23d88554d0e4644450a29aa645469e12e92cee9908ced1dd3115c018c3f8080560453eb0720ccdc"
						}
					}
					@{
						ISO = "nl-nl_windows_10_consumer_editions_version_22h2_x64_dvd_832a14fa.iso"
						CRCSHA = @{
							SHA256 = "25c018d92a0ecfa372cd9f15b3241fbfce1d982225e70040d1573df37105ed0f"
							SHA512 = "7f40ac4a4cf3f179f078f9f16f74ecf231f27e490acd708496a15bb50ae7a15a2c7a2a96032c3df02d022a59b2985d538de1971231a098a036b6966bd450a0fd"
						}
					}
					@{
						ISO = "pl-pl_windows_10_consumer_editions_version_22h2_x64_dvd_2a7aebca.iso"
						CRCSHA = @{
							SHA256 = "821484eecbdf80540f341020749b5d7d44915a903ebfd25e5358969185d6f7a6"
							SHA512 = "efde6b4bfdc9e8537c49d47e3d81b087441e6876bab125f52e1787dfd7514b5ecf39e50f110a1ae7d29b37e526b7e04d82fa29207891bff672d3d548b47ec542"
						}
					}
					@{
						ISO = "pt-br_windows_10_consumer_editions_version_22h2_x64_dvd_cada68e3.iso"
						CRCSHA = @{
							SHA256 = "483df0067d5bc9744d1acbdf21a0c94b1c072345679f8165aef2684abc9f8127"
							SHA512 = "e55c9fcf77f97ebd430a9d93c63c6dfb9988ac940efb4f2fd2d8c8e8a33aa2e8091955315f44f6084196b48d85c8a826e225d007c629d043a38307ee51115744"
						}
					}
					@{
						ISO = "pt-pt_windows_10_consumer_editions_version_22h2_x64_dvd_81a903fb.iso"
						CRCSHA = @{
							SHA256 = "cfde020588ac73cbe2c812288a99c01eb2b350f7791247532049090fee0de0b0"
							SHA512 = "9e2d52f5c6742aa463a74850a23f4768786d61a638ef320d5c0c35bf14da9e2abb3865ec0b16798d12cee3e3cebba777398a43e50143debddbba0b7b5fe0e28f"
						}
					}
					@{
						ISO = "ro-ro_windows_10_consumer_editions_version_22h2_x64_dvd_0588db37.iso"
						CRCSHA = @{
							SHA256 = "b2c6b86e144fa39f49a4bbd79c8b232a1108bad1204db7176336fb66a408016a"
							SHA512 = "10339d8a2568ac679778f1d9e317c007407e5b58adfdc263423614837e0191cec4c73b17296d6069aaf33da4216554ad3c8bce4f1caf3c020fc28eeeaef24cfa"
						}
					}
					@{
						ISO = "ru-ru_windows_10_consumer_editions_version_22h2_x64_dvd_86fd5014.iso"
						CRCSHA = @{
							SHA256 = "da678e01bd85c561c45a0c2a92c0b6730b610c2d6fc6683345355f9f21e0eb72"
							SHA512 = "0f89f13592248b9377dda05ad7ce6f8212032a84b8147ea6f4241d02133aedf6e4b5e273e17908628ef4777d13b661adbd5c77b4f04cb7ed5f9e833bbb3471ea"
						}
					}
					@{
						ISO = "sk-sk_windows_10_consumer_editions_version_22h2_x64_dvd_e4f75f76.iso"
						CRCSHA = @{
							SHA256 = "2950667ceb4fb008bad7be6b32f014fe68017f319b5721c6e50f4e9c378f2d8a"
							SHA512 = "90bb8dd5080202563feed6a2f41b4bcdb75f915bde7c40613d2f75624f68e8cdfe9022eb6adb326162c899d2d0c7c4aa4237cd3413bc4bd557445a315c0991ad"
						}
					}
					@{
						ISO = "sl-si_windows_10_consumer_editions_version_22h2_x64_dvd_73c2654f.iso"
						CRCSHA = @{
							SHA256 = "dfa18e7dd4d8939b5b48a258a21aa84cde0efbe62188558057f79f143040a530"
							SHA512 = "d083fd47c4e6b19d7e78153acd14c893fe02ad6907660fcb2ce61afb49eb8db9636df639f6b5d40bf07841bc3b104951e11ac411d1e03d8ac182f3f7d952b09d"
						}
					}
					@{
						ISO = "sr-latn-rs_windows_10_consumer_editions_version_22h2_x64_dvd_45e1eb1f.iso"
						CRCSHA = @{
							SHA256 = "bc7aef4b0dc5ac9cf1915d949f6e81f8d06a8829166646ba4193f78eda8412b4"
							SHA512 = "a87daebbee30b362d140ae9c9ab184f1bafedbb78ca207e31f8718805ed490c57dfb7d626e7fabcbfc835c83ccc341cc8a4da64430b2f1b820ce85a01ce5e422"
						}
					}
					@{
						ISO = "sv-se_windows_10_consumer_editions_version_22h2_x64_dvd_fdecb088.iso"
						CRCSHA = @{
							SHA256 = "8762b81dfcb76a8bb5c000de7b8831f98729f641025a453353bfe1b6d57906a3"
							SHA512 = "e1217060cbcb7a6bc32e3605835a3ce92518ae3f31b51de0d72a2fe10a4393001168cbfd6235fb43d06c90a80ce10c722b198b62b7a9d53d1db505bfe5a59f0e"
						}
					}
					@{
						ISO = "th-th_windows_10_consumer_editions_version_22h2_x64_dvd_4f49e172.iso"
						CRCSHA = @{
							SHA256 = "7fe00198b938b01301a8946c8fdd0b03b34dc17d468cbc05315a2d84e7d0e609"
							SHA512 = "55b2651e7df97fd149dd72b04884c9c2181a5df078015e1b73169a3a56b4577654adc7ae417df9069efd4c00dd6956eb05aa3bb6622fdc044a72d36183771425"
						}
					}
					@{
						ISO = "tr-tr_windows_10_consumer_editions_version_22h2_x64_dvd_5abe5001.iso"
						CRCSHA = @{
							SHA256 = "2c936ddcf017a8d9d8d0512abf39a23d5ff3b89ae5951753e3d4f02810b3401d"
							SHA512 = "2ae009586235d9d2b628bf4368ae0b40dadc87d69da447e0f4582cb2b4673c69f412f19a1cf45d62ed8fe78d4da85d2398c89ab3d1fb00765228e24d2f00ad61"
						}
					}
					@{
						ISO = "uk-ua_windows_10_consumer_editions_version_22h2_x64_dvd_0afe1fa6.iso"
						CRCSHA = @{
							SHA256 = "b818b2cf1d39df2e876f10b9c13c6dd132f95cc68888c7a14261880f329f5783"
							SHA512 = "59930be043e578f40dde9c10998e4cd8277fb74e03c41431c76475b4055980cf93c7e3ea7aa78e11f6c8bc869777b52013ed6869b192cbde84ad67e11f0e1846"
						}
					}
					@{
						ISO = "zh-cn_windows_10_consumer_editions_version_22h2_x64_dvd_139de365.iso"
						CRCSHA = @{
							SHA256 = "C11AF92280BC9FCF90431A3487B3C390B8227C16B897BAFD67A0919710B22691"
							SHA512 = "af2cb6f50359bf2cabc4860dbf029440e311100e0dd6e18e7669ac3814e308698ac73ab57b5db862a2a906b64ed5c3533a1355bd5a6e53a655dc230b4c7ca6b3"
						}
					}
					@{
						ISO = "zh-tw_windows_10_consumer_editions_version_22h2_x64_dvd_93d5f800.iso"
						CRCSHA = @{
							SHA256 = "1ef2c88cce50e0e10c9b83c2eb11131d5fed5af464496f5d071c8d9732b2a4a4"
							SHA512 = "5378c9198fbb73bb63f42cd47448d6f6398766d1eebe925b6bfb06cce7dc902eb068b1bc0155786ef9fb96729fa19194b5e3da49041c45116b961ca282a96867"
						}
					}
					#endregion
		
					#region x86
					@{
						ISO = "en-us_windows_10_consumer_editions_version_22h2_x86_dvd_90883feb.iso"
						CRCSHA = @{
							SHA256 = "7cb5e0e18b0066396a48235d6e56d48475225e027c17c0702ea53e05b7409807"
							SHA512 = "d3c2f7d7188ece1bed197581f495071646411522560a9459789efd2afd0d7bc88d940b6150c7cb09aad737b45f33ef622c806892c9aa7174e000b8ae51e11dc4"
						}
					}
					@{
						ISO = "ar-sa_windows_10_consumer_editions_version_22h2_x86_dvd_c853aa74.iso"
						CRCSHA = @{
							SHA256 = "5854bdbc8c9b9e5ddf58faba9d2537a87ce6667173e92fad2c123178f7b1f3d7"
							SHA512 = "935e1c8014425ebe87ccf1052af94f0cc7187a983e684a21c53c538895783952cefc842357fa4671d7aae654eeabf3318708965d4c07a39a38117c94a17164ad"
						}
					}
					@{
						ISO = "bg-bg_windows_10_consumer_editions_version_22h2_x86_dvd_93c582ae.iso"
						CRCSHA = @{
							SHA256 = "c94b1aca360c6a3eaa9f412c46c5812bc87e2f530c07990fac8db3bbf19afeaa"
							SHA512 = "2a41e9e101f5fa392ce857094fa575c574eda74daeba8c96ec42496de6fd2522adf90f5feb4202fcd64b58ee32c749cb7582b31d7f9f946922cd2324e07f55c9"
						}
					}
					@{
						ISO = "cs-cz_windows_10_consumer_editions_version_22h2_x86_dvd_f74bbb55.iso"
						CRCSHA = @{
							SHA256 = "8c886d0483421836055abcb8ab6fd19b7363d4c9b8839196b25dd237d9d310d7"
							SHA512 = "6206855639151223b8d18460b78640368bd06f0001dbc41f75e1b6b8f179143df6d409eeaab01b1f76c7938d03a1bbab2b23ecef57625c6fb4f644238a9338ad"
						}
					}
					@{
						ISO = "da-dk_windows_10_consumer_editions_version_22h2_x86_dvd_aa22b3e4.iso"
						CRCSHA = @{
							SHA256 = "2850706ac681700ceb29b3ee48c73f2b9917e070e0ad60ad2651cca708947ffa"
							SHA512 = "8510d94b9a6a8962c50f731c400cf2a8515529ac14b7fe51b98f8325bd5579244cdc79b466bc2d64b8142d8202a7958ea52383500c423cdbcd0a7a9581fff778"
						}
					}
					@{
						ISO = "de-de_windows_10_consumer_editions_version_22h2_x86_dvd_de98c89f.iso"
						CRCSHA = @{
							SHA256 = "33f7a6d6e16e745c2409224bca7eb254bb84cda1a3785541485d08ba315a073a"
							SHA512 = "cd55522cefd2170e7523805f679de2ee0379710089f978afeaf97faa087dff5ac3889f77f04509a86a560d2298cfd2763df02b7bf69bc0e3a50ae934cf520203"
						}
					}
					@{
						ISO = "el-gr_windows_10_consumer_editions_version_22h2_x86_dvd_c7b9a8e8.iso"
						CRCSHA = @{
							SHA256 = "4c7dcdd6307318485c6cc790ca0c2cd6153491c16d9b1442da755fd848289b61"
							SHA512 = "c0ef60b4f2cab060c1f2ef4e164a14b84e825598a983162c4090a3ac4bc390a78c36f0c0dd6a38e25a798adbd55d122e36a14028dfdfb1fa72f461756cd7f17f"
						}
					}
					@{
						ISO = "en-gb_windows_10_consumer_editions_version_22h2_x86_dvd_fe92e18d.iso"
						CRCSHA = @{
							SHA256 = "882317c2323e05c19eaf6ea67a497fc42ccbb7c644cd88280868d495060d6a2b"
							SHA512 = "6d9496339ad8842ec9bbd61c918366e8be1d882e535839d9c55cdd2b306e08093a2b8a85b1e2db46c8b13c4265fc20ad7b8f13509fea42a1aa8e13c05bd91f55"
						}
					}
					@{
						ISO = "es-es_windows_10_consumer_editions_version_22h2_x86_dvd_337e099c.iso"
						CRCSHA = @{
							SHA256 = "b81f23400b3dda4dfb38c087e92e26452b16a7becf3d7a8c356852893eb7f354"
							SHA512 = "fe7fae12e6e096e534f6d799899fe552eedf5f0b53d86bbe49490d3e7c623425b6481da301bc06f6e0555405ac86977ab0b13495ad7b614a2753cba1daf0b6e7"
						}
					}
					@{
						ISO = "es-mx_windows_10_consumer_editions_version_22h2_x86_dvd_f8711106.iso"
						CRCSHA = @{
							SHA256 = "a76d6a13cc936c8c862753099dedc1144f7d6d1d237791aae0fdff389afe26b9"
							SHA512 = "9ab99795b85c3c68f3c7a58ca67f6828bf863c0364ddbc74b0c26714cda1e646ed03c52ab23d5e856369710b0ae22d933b6f6077fab2174403c0ccf9279a8623"
						}
					}
					@{
						ISO = "et-ee_windows_10_consumer_editions_version_22h2_x86_dvd_ab421c0c.iso"
						CRCSHA = @{
							SHA256 = "faaf4361d947e15ec9ea8c2aa6c4536ad518c51166489e9ecefdfe620d2910c3"
							SHA512 = "4c605c4a310da7bf49928c23d2a4aea25435553625ed830a7d03e602b7fff5a112a97404a3857f0e89d5ef12bf6af3ffe485697b981be6ca5ec7f808eb3154c5"
						}
					}
					@{
						ISO = "fi-fi_windows_10_consumer_editions_version_22h2_x86_dvd_3a686e70.iso"
						CRCSHA = @{
							SHA256 = "8406a222aa7f53f8273b4dc27e3beb055c1e702ec17291a141cfb3827c928696"
							SHA512 = "aab79e3afa208f6989b647ae7d48e711b723669810007a98801c8c7ef9ba625a0bcd922499b259aee45aa61c6a5c51d8302fd594e05808b4c54dcc1c0fc0916e"
						}
					}
					@{
						ISO = "fr-ca_windows_10_consumer_editions_version_22h2_x86_dvd_dfdd1d4b.iso"
						CRCSHA = @{
							SHA256 = "6107a295f227e500a69f6443ca6201dde079eac638c720ee91bec110d5414c4c"
							SHA512 = "d55cff926ed42e0f8c87dec530a164ae20d5f9bd55e3570d86579280907eaa05e4048e947bc6ffbbe553938f096ceec8c54f7a5c3e9abf1edb1a289f4c69c417"
						}
					}
					@{
						ISO = "fr-fr_windows_10_consumer_editions_version_22h2_x86_dvd_a7dc9f84.iso"
						CRCSHA = @{
							SHA256 = "c95bac30e70be1d6536d51410206ed0067638550eed7cffecf02fab92fce43fc"
							SHA512 = "7f8763f5fc6d26b909b58dedfb5d4e00582d0ab013de0675e66ecdcd8142c0ec3520d78d0320342f1a509d8e83af5c81219a0bb51bedc46e135b16c8c4a0ae2e"
						}
					}
					@{
						ISO = "he-il_windows_10_consumer_editions_version_22h2_x86_dvd_69cdbef4.iso"
						CRCSHA = @{
							SHA256 = "5cbbfb20b7474c5a06c4c3805e7a17cc85fce8d6830fb0806a0eb5fd60c36a29"
							SHA512 = "b2412af0c7fd7bc5972008f074a694a2cdadc1cb513b0b17f78b41226c1aed781f7d447160f5f0f677e7b1430e8bab2ea746c047a640602c95ad5f370c61bcb6"
						}
					}
					@{
						ISO = "hr-hr_windows_10_consumer_editions_version_22h2_x86_dvd_08246fed.iso"
						CRCSHA = @{
							SHA256 = "ea475737cb754f6729255e033fdcb1577c36dff884c244175d83fd2f82e85093"
							SHA512 = "e1b6eb02b0af563b7f61a63fc43e8641257d6ace8e4e9679b575f4ec34b42e17a66a4d217cb39496882cc22f1b4660187271ea529e5a6928459868c1cdb5443b"
						}
					}
					@{
						ISO = "hu-hu_windows_10_consumer_editions_version_22h2_x86_dvd_8ce8b8c0.iso"
						CRCSHA = @{
							SHA256 = "29fac151366e23ed6b38a02f5ed0f210fef286ad7bbc3c7fe8001a5fa789eeb0"
							SHA512 = "97fe6c83a3238e511025e00458e869d95f56c6ae4256252b500d27fb6bf93500beebf1cf14a6a45605dcc7f05af3bd0894e838277c5203e4c98b1e5558d6751d"
						}
					}
					@{
						ISO = "it-it_windows_10_consumer_editions_version_22h2_x86_dvd_2088022d.iso"
						CRCSHA = @{
							SHA256 = "2e136f75a9b08f2727bd204aec80034eafb3d2846573a92b32493b510869aaf9"
							SHA512 = "9738412b78be7d6833cedb1c30f8ae0f3ff081d402f2ba73002510f014fb3149324d86518e6f6a6ad3ed40dacaa3981dd59691b6ac21728be4072eaa0d0ce545"
						}
					}
					@{
						ISO = "ja-jp_windows_10_consumer_editions_version_22h2_x86_dvd_643d1ca2.iso"
						CRCSHA = @{
							SHA256 = "517b4997b33344e5e1bad1d64a939c59313a7b4b164f4b1244bb044142be1f09"
							SHA512 = "440083c20660000a870d47ccc430563d4f5cfa26d483f7fbf6ab927ee57c1aaf9e15490fd584b9411fe499f66a04547fade8276a3e929fe5da9e44c1480ceef6"
						}
					}
					@{
						ISO = "ko-kr_windows_10_consumer_editions_version_22h2_x86_dvd_d04ea4b7.iso"
						CRCSHA = @{
							SHA256 = "5a43752e8717a78d12eaba5906dfb64dc1f9455057fbb0332c833fa87f3f6a2f"
							SHA512 = "8e1edd7447cf4cd9b1d1f9be649a6c5512208154f475eda594d9ef45e94333324650af18b1241f2d27fd752e763787c219774ce131c9eb09e425e8bd718d0763"
						}
					}
					@{
						ISO = "lt-lt_windows_10_consumer_editions_version_22h2_x86_dvd_a372ac4c.iso"
						CRCSHA = @{
							SHA256 = "90e1b655588755fbf3081adfabd9aaa3b9f75a9a4cd514f5b048ef2135414a6d"
							SHA512 = "9c93653769054571f408ec992a3de16dfcddcad9a9dd3df1e29d6def4c3097e45b7b20101f7c8a2eba054716a0c0584cd0ef654cc7d7e7f18b5b25e1812ad5e7"
						}
					}
					@{
						ISO = "lv-lv_windows_10_consumer_editions_version_22h2_x86_dvd_f25ea179.iso"
						CRCSHA = @{
							SHA256 = "1623d177af41e15bd349bfccb4a96c8b856568ebb16a12196ee217cf19f8e1c7"
							SHA512 = "5415a3ff74cd5864adb04609bdaba908acea6a00513a0378ad3b0e7d6dc0ce8f6287ccb2e6d468a5d94bda7f108b6e2efa18e27ec7e978a9c7882951c5e0aa70"
						}
					}
					@{
						ISO = "nb-no_windows_10_consumer_editions_version_22h2_x86_dvd_4fd27bb3.iso"
						CRCSHA = @{
							SHA256 = "f395ee493090bdaa91d4fc52bbf6072791a004e247ab16468346f1a748d0295c"
							SHA512 = "34986346ee535baf89dc9ec2034c8e7e08084b82b819a0c5ef3e1118e6aeb4b76154e26fcdc3cde5b3ecbe7371c7fc4c6abef89dacf9707f2f57eaf1f56152a6"
						}
					}
					@{
						ISO = "nl-nl_windows_10_consumer_editions_version_22h2_x86_dvd_5ac7b647.iso"
						CRCSHA = @{
							SHA256 = "924ea5faf58d69aabae90cac24a661d0df4c8822e8a1cbf4105fa2353eecb133"
							SHA512 = "59bc56686c96729e18cbc5419bd8b8cbd5fbe658fb3e23e2c4f933d6e4bb87e9c2eea30060a0acb300689d3fec1965e6fce7bc313c04dfc4899ba02a5fc0193a"
						}
					}
					@{
						ISO = "pl-pl_windows_10_consumer_editions_version_22h2_x86_dvd_299fa74e.iso"
						CRCSHA = @{
							SHA256 = "5498dce2ca9c6d3d0f6383107d9a3aff6db528a4d44f59092f763d641f5ba8be"
							SHA512 = "7497accf56c09c81df9517ae40dbcddebd267a5e14f508f47779b6da205d57b46766f823a9c53a5d2688edd5ddcf64ce03dd0fd556711e66c8b0af2b93869169"
						}
					}
					@{
						ISO = "pt-br_windows_10_consumer_editions_version_22h2_x86_dvd_79cd5eea.iso"
						CRCSHA = @{
							SHA256 = "c3fb88cba36010d52f3b659c225d570935ea4aebb7d135d9cd523e04502d0c13"
							SHA512 = "455d46478eb6310f93b98d1afc7f15fa0d612cad022fc02d5af5c791145a8794b96b0d316d1d6e4fa0cfca4e467d20e53d419bb8178745d92b6dda4f1e730ae1"
						}
					}
					@{
						ISO = "pt-pt_windows_10_consumer_editions_version_22h2_x86_dvd_d1dfea71.iso"
						CRCSHA = @{
							SHA256 = "ef597f353f383220a595cadbe318276268aa0a692fd6061db8183ed3a1d4f071"
							SHA512 = "3d8b0d5d0fdcadf2dd41b474d07a2f7d62c052e75e4157214edc3ec0d0689cf7db6d74b12bc74526327e5da71d607bb1e841234b11a147d74e3409b087c1560e"
						}
					}
					@{
						ISO = "ro-ro_windows_10_consumer_editions_version_22h2_x86_dvd_3c60b8ef.iso"
						CRCSHA = @{
							SHA256 = "9ee8ea8105836277330b39d905a75776e35035f4e7ce232dc7525d7ebd2fa6a5"
							SHA512 = "570dff1168f457e20d2e6f161904c5de0936aeb8fb22b5092d2d541de793847cadd14d6f1ff129dcceb7bc2cf2ac2e3ac94496833f6efd6e1438cfd900082fec"
						}
					}
					@{
						ISO = "ru-ru_windows_10_consumer_editions_version_22h2_x86_dvd_2e77f200.iso"
						CRCSHA = @{
							SHA256 = "45cd4116419c5dd4f8dcee4f81ba7b56b5d58424b1c52dbc07d90973e5537a32"
							SHA512 = "c1a288b65e629375e645d5e72981202d1045b74068ed2f3a3453ac9b15cedd6d8deb435a9be48da4fd8946786b26c4a0a6fd8119c219076930fa5664990c76f9"
						}
					}
					@{
						ISO = "sk-sk_windows_10_consumer_editions_version_22h2_x86_dvd_b65f73ff.iso"
						CRCSHA = @{
							SHA256 = "ccd421a6925db49fd7bf692653f4cefcccad142ca5f4dcc2dacae5ce912bf418"
							SHA512 = "172da73eefd426d1d3931e3c71ec6610593aa4e782245e840a73e162f2915434f78b439bfa0e4b77137a5d51cc7a09298d457b6a9c09b76e209521bea56a9f08"
						}
					}
					@{
						ISO = "sl-si_windows_10_consumer_editions_version_22h2_x86_dvd_352d28bd.iso"
						CRCSHA = @{
							SHA256 = "f890cec9eccbb4511d7910628571de5cdf20a04a6b72bb17fd1352a52ed1f323"
							SHA512 = "824ee3cc72d7a146f179cc98126264ee52b8a860bff8e076833f029ba5489a26ff2d06eeda7deb32194bb92c6d7d2f85ed931182cea3da78180a6702b58c6065"
						}
					}
					@{
						ISO = "sr-latn-rs_windows_10_consumer_editions_version_22h2_x86_dvd_729f26e7.iso"
						CRCSHA = @{
							SHA256 = "b9f5cd7173f28d27b83389a8acb6d8b95a12394c76ff7701a1e43714f0f71be1"
							SHA512 = "6ff0ddd47c6c35892bdc6eb8c1802920fb185c840540d8e525c298b0c234d131a26c138077f3915168fe76863dd592243a3a6acd0dd44d0cceab935b5bbab692"
						}
					}
					@{
						ISO = "sv-se_windows_10_consumer_editions_version_22h2_x86_dvd_f8f13351.iso"
						CRCSHA = @{
							SHA256 = "cc64b3e0d17505675fff3d7410e4c940073f29a79834b91a9eeeea93110ee352"
							SHA512 = "97e892c187a1222cb8a01f578f8e389e645403c1eb72fd6089f12149e18c086c3bb8fe481585dfa28fdd61f7237c899c464641f305b2065853e8cf763b015a92"
						}
					}
					@{
						ISO = "th-th_windows_10_consumer_editions_version_22h2_x86_dvd_cb3ee978.iso"
						CRCSHA = @{
							SHA256 = "dd7ecfcec4c95ab18ee79b5fdf12bfcfb6ff4b26d5fc3dfac6ca506a18fb418b"
							SHA512 = "7abb0806bb5569477898cc0dafd80e992863eed2e26b2d92023af9f2afe861c6af2c29a00becd37b378d43a3df07de78130640d62b1d294a6479e3a7146cb24f"
						}
					}
					@{
						ISO = "tr-tr_windows_10_consumer_editions_version_22h2_x86_dvd_170acddd.iso"
						CRCSHA = @{
							SHA256 = "598d5b8a5f4fefb4d4aaa185dd9f6cbb2cce1773c9aed52ea98a7eb3fc477f9b"
							SHA512 = "4eea41fc39e635cf83a2e582a572bbe2485c4159b574d8e5744210aa19f16b725cae395f39c8a970468bbbd3730062fbfb4aef8501ebf0f44db8fe543771aea2"
						}
					}
					@{
						ISO = "uk-ua_windows_10_consumer_editions_version_22h2_x86_dvd_5eca6422.iso"
						CRCSHA = @{
							SHA256 = "721889967b6adb06531c3711e737fbd61bea0a0d84f38a7b99e83d5ba01f2375"
							SHA512 = "d3d1b460464db08e02a4a914765defe4a96333e83ee4648a084e6179426ac6d48f00403add28a71f8fbdafa6d4f860b1c08fef2561003a21e473a5191fd8e01e"
						}
					}
					@{
						ISO = "zh-cn_windows_10_consumer_editions_version_22h2_x86_dvd_fa2c4567.iso"
						CRCSHA = @{
							SHA256 = "972ca12ed12cfb701a3d1d4e44bbc010f5d87ae0993d9ce7d5f6f66ba049324e"
							SHA512 = "31573219323a2330e9db6bee09e0151df2a2e8cc7fa8dc683ce9297b32e946be018144df63afbd22ebccf98c142709429ab06045452b536126ded1528b92a30d"
						}
					}
					@{
						ISO = "zh-tw_windows_10_consumer_editions_version_22h2_x86_dvd_05368209.iso"
						CRCSHA = @{
							SHA256 = "7e9ad1b1d5fdb4053aef59d4d49a57224d92a6a747fc25e174ec3d7b2142c8e9"
							SHA512 = "bdcc8ea3e9b333c1518a1d2aa6705c90611711c06b36628933cce9f874b83b1366a15c7570d5351315910df5db6828651c934e4dcc2a3d957f6d9b61d847b8fe"
						}
					}
					#endregion
		
					#region Windows 10 IoT Enterprise 22H2
					@{
						ISO = "https://drive.massgrave.dev/en-us_windows_10_iot_enterprise_version_22h2_x64_dvd_51cc370f.iso"
						CRCSHA = @{
							SHA256 = "2070c6eb71143a1207805f264d756b25f985769452f0bafccadf393c85d47f30"
							SHA512 = "2cdd3533a63a764bc1b98b7c43857d4a3ca95be069fecef565f9610f52cdb16b2f4e5abcbb2fc45daa6678720e0e6a4dfb17ee354640a2c7f5a5167897c7ac27"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/en-us_windows_10_iot_enterprise_version_22h2_arm64_dvd_39566b6b.iso"
						CRCSHA = @{
							SHA256 = "aad4fff6702e681c3238dfc64da6a58beefc8246e8b75170b30b52af31d20f0b"
							SHA512 = "76260e42fdce2dbea403e38ac65e39840f7e165f7cfd6c166e17fa7df342166e44ddcc0b4915fd00bf1d2fc2bc41e3c456ecfac6bbbceac9d7952d7d681666ad"
						}
					}
		
					@{
						ISO = "en-us_windows_10_enterprise_ltsc_2021_x64_dvd_d289cf96.iso"
						CRCSHA = @{
							SHA256 = "c90a6df8997bf49e56b9673982f3e80745058723a707aef8f22998ae6479597d"
							SHA512 = "0a2cd4cadf0395f0374974cd2bc2407e5cc65c111275acdffb6ecc5a2026eee9e1bb3da528b35c7f0ff4b64563a74857d5c2149051e281cc09ebd0d1968be9aa"
						}
					}
					@{
						ISO = "en-us_windows_10_enterprise_ltsc_2021_x86_dvd_9f4aa95f.iso"
						CRCSHA = @{
							SHA256 = "3276d60fa27f513b411224cd474278a9abe406159ba47776747862c7080292bc"
							SHA512 = "438e6c9b2d074d5270b263e9aeb662387d2bdc4a020607d77fa1697a134fdd186a752af5a93d587d560fde02d26450725e25b4c3d8b80187914528b3c6062bbd"
						}
					}
					#endregion
		
					
					#region Windows 10 Iot Enterprise LTSC 2021
					@{
						ISO = "https://drive.massgrave.dev/en-us_windows_10_iot_enterprise_ltsc_2021_x64_dvd_257ad90f.iso"
						CRCSHA = @{
							SHA256 = "a0334f31ea7a3e6932b9ad7206608248f0bd40698bfb8fc65f14fc5e4976c160"
							SHA512 = "640942d93daf8cd183d06e35d5d753a4b93c952c3196c3e3fa7876295b39d8bfef5df8ef2a3b420b5247905fe396606f94ccf093982ee999e503d09e69850143"
						}
					}
					@{
						ISO = "https://drive.massgrave.dev/en-us_windows_10_iot_enterprise_ltsc_2021_arm64_dvd_e8d4fc46.iso"
						CRCSHA = @{
							SHA256 = "d265df49b30a1477d010c79185a7bc88591a1be4b3eb690c994bed828ea17c00"
							SHA512 = "cbf5196a0a539f5285b8c98eea093823bd396cad8d7d34e25936bfc5936a1c86d040d938c6ae49bd8483325e0f2a87c231f005a3a01edb353adea82dfb006720"
						}
					}
				)
				InboxApps   = @{
					ISO = @(
						@{
							ISO = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/19041.3031.230508-1728.vb_release_svc_prod3_amd64fre_InboxApps.iso"
							CRCSHA = @{
								SHA256 = "6c5b583738e3c33b00c912783d1743ebe2e240e12fa3d9803d446f1b88675c14"
								SHA512 = ""
							}
						}
					)
					Edition = @(
						#region Group 1
						@{
							Name = @(
								"Core"
								"CoreSingleLanguage"
								"Education"
								"Professional"
								"ProfessionalEducation"
								"ProfessionalWorkstation"
								"Enterprise"
								"IoTEnterprise"
								"ServerRdsh"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.0"
								"Microsoft.UI.Xaml.2.1"
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.Advertising.Xaml"
								"Microsoft.NET.Native.Framework.1.7"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.1.7"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.HEIFImageExtension"
								"Microsoft.WebpImageExtension"
								"Microsoft.VP9VideoExtensions"
								"Microsoft.WindowsStore"
								"Microsoft.Xbox.TCUI"
								"Microsoft.XboxApp"
								"Microsoft.XboxGameOverlay"
								"Microsoft.XboxGamingOverlay"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.Cortana"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.GetHelp"
								"Microsoft.Getstarted"
								"Microsoft.Microsoft3DViewer"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.MicrosoftSolitaireCollection"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.MixedReality.Portal"
								"Microsoft.MSPaint"
								"Microsoft.Office.OneNote"
								"Microsoft.People"
								"Microsoft.ScreenSketch"
								"Microsoft.SkypeApp"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Wallet"
								"Microsoft.WebMediaExtensions"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsCalculator"
								"Microsoft.WindowsCamera"
								"Microsoft.windowscommunicationsapps"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.WindowsSoundRecorder"
								"Microsoft.YourPhone"
								"Microsoft.ZuneMusic"
								"Microsoft.ZuneVideo"
							)
						}
						#endregion
		
						#region Group 2
						@{
							Name = @(
								"EnterpriseN"
								"EnterpriseGN"
								"EnterpriseSN"
								"ProfessionalN"
								"CoreN"
								"EducationN"
								"ProfessionalWorkstationN"
								"ProfessionalEducationN"
								"CloudN"
								"CloudEN"
								"CloudEditionLN"
								"StarterN"
							)
							Apps = @(
								"Microsoft.UI.Xaml.2.0"
								"Microsoft.UI.Xaml.2.1"
								"Microsoft.UI.Xaml.2.3"
								"Microsoft.Advertising.Xaml"
								"Microsoft.NET.Native.Framework.1.7"
								"Microsoft.NET.Native.Framework.2.2"
								"Microsoft.NET.Native.Runtime.1.7"
								"Microsoft.NET.Native.Runtime.2.2"
								"Microsoft.VCLibs.140.00"
								"Microsoft.VCLibs.140.00.UWPDesktop"
								"Microsoft.Services.Store.Engagement"
								"Microsoft.WindowsStore"
								"Microsoft.XboxApp"
								"Microsoft.XboxGameOverlay"
								"Microsoft.XboxIdentityProvider"
								"Microsoft.XboxSpeechToTextOverlay"
								"Microsoft.Cortana"
								"Microsoft.BingWeather"
								"Microsoft.DesktopAppInstaller"
								"Microsoft.GetHelp"
								"Microsoft.Getstarted"
								"Microsoft.Microsoft3DViewer"
								"Microsoft.MicrosoftOfficeHub"
								"Microsoft.MicrosoftSolitaireCollection"
								"Microsoft.MicrosoftStickyNotes"
								"Microsoft.MSPaint"
								"Microsoft.Office.OneNote"
								"Microsoft.People"
								"Microsoft.ScreenSketch"
								"Microsoft.StorePurchaseApp"
								"Microsoft.Wallet"
								"Microsoft.Windows.Photos"
								"Microsoft.WindowsAlarms"
								"Microsoft.WindowsCalculator"
								"Microsoft.WindowsCamera"
								"Microsoft.windowscommunicationsapps"
								"Microsoft.WindowsFeedbackHub"
								"Microsoft.WindowsMaps"
								"Microsoft.YourPhone"
							)
						}
						#endregion
					)
					Rule = @(
						@{ Name ="Microsoft.UI.Xaml.2.0";                       Match = "UI.Xaml*2.0";                       License = "UI.Xaml*2.0";                       Dependencies = @(); }
						@{ Name ="Microsoft.UI.Xaml.2.1";                       Match = "UI.Xaml*2.1";                       License = "UI.Xaml*2.1";                       Dependencies = @(); }
						@{ Name ="Microsoft.UI.Xaml.2.3";                       Match = "UI.Xaml*2.3";                       License = "UI.Xaml*2.3";                       Dependencies = @(); }
						@{ Name ="Microsoft.Advertising.Xaml";                  Match = "Advertising.Xaml";                  License = "Advertising.Xaml";                  Dependencies = @(); }
						@{ Name ="Microsoft.NET.Native.Framework.1.7";          Match = "Native.Framework*1.7";              License = "Native.Framework*1.7";              Dependencies = @(); }
						@{ Name ="Microsoft.NET.Native.Framework.2.2";          Match = "Native.Framework*2.2";              License = "Native.Framework*2.2";              Dependencies = @(); }
						@{ Name ="Microsoft.NET.Native.Runtime.1.7";            Match = "Native.Runtime*1.7";                License = "Native.Runtime*1.7";                Dependencies = @(); }
						@{ Name ="Microsoft.NET.Native.Runtime.2.2";            Match = "Native.Runtime*2.2";                License = "Native.Runtime*2.2";                Dependencies = @(); }
						@{ Name ="Microsoft.VCLibs.140.00";                     Match = "VCLibs*14.00";                      License = "VCLibs*14.00";                      Dependencies = @(); }
						@{ Name ="Microsoft.VCLibs.140.00.UWPDesktop";          Match = "VCLibs*Desktop";                    License = "VCLibs*Desktop";                    Dependencies = @(); }
						@{ Name ="Microsoft.Services.Store.Engagement*{ARCHC}"; Match = "Services.Store.Engagement*{ARCHC}"; License = "Services.Store.Engagement*{ARCHC}"; Dependencies = @(); }
						@{ Name ="Microsoft.HEIFImageExtension";                Match = "HEIFImageExtension";                License = "HEIFImageExtension";                Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WebpImageExtension";                Match = "WebpImageExtension";                License = "WebpImageExtension";                Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.VP9VideoExtensions";                Match = "VP9VideoExtensions";                License = "VP9VideoExtensions";                Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WindowsStore";                      Match = "WindowsStore";                      License = "WindowsStore";                      Dependencies = @("Microsoft.UI.Xaml.2.3"; "Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.Xbox.TCUI";                         Match = "Xbox.TCUI";                         License = "Xbox.TCUI";                         Dependencies = @("Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.XboxApp";                           Match = "XboxApp";                           License = "XboxApp";                           Dependencies = @("Microsoft.NET.Native.Framework.1.7"; "Microsoft.NET.Native.Runtime.1.7"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.XboxGameOverlay";                   Match = "XboxGameOverlay";                   License = "XboxGameOverlay";                   Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.XboxGamingOverlay";                 Match = "XboxGamingOverlay";                 License = "XboxGamingOverlay";                 Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.XboxIdentityProvider";              Match = "XboxIdentityProvider";              License = "XboxIdentityProvider";              Dependencies = @("Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.XboxSpeechToTextOverlay";           Match = "XboxSpeechToTextOverlay";           License = "XboxSpeechToTextOverlay";           Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.Cortana";                           Match = "Cortana";                           License = "Cortana";                           Dependencies = @("Microsoft.UI.Xaml.2.3"; "Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"; "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name ="Microsoft.BingWeather";                       Match = "BingWeather";                       License = "BingWeather";                       Dependencies = @("Microsoft.UI.Xaml.2.1"; "Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"; "Microsoft.Advertising.Xaml"); }
						@{ Name ="Microsoft.DesktopAppInstaller";               Match = "DesktopAppInstaller";               License = "DesktopAppInstaller";               Dependencies = @("Microsoft.VCLibs.140.00"; "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name ="Microsoft.GetHelp";                           Match = "GetHelp";                           License = "GetHelp";                           Dependencies = @("Microsoft.NET.Native.Framework.1.7"; "Microsoft.NET.Native.Runtime.1.7"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.Getstarted";                        Match = "Getstarted";                        License = "Getstarted";                        Dependencies = @("Microsoft.UI.Xaml.2.3"; "Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.Microsoft3DViewer";                 Match = "Microsoft3DViewer";                 License = "Microsoft3DViewer";                 Dependencies = @("Microsoft.UI.Xaml.2.1"; "Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"; "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name ="Microsoft.MicrosoftOfficeHub";                Match = "MicrosoftOfficeHub";                License = "MicrosoftOfficeHub";                Dependencies = @("Microsoft.VCLibs.140.00"; "Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.MicrosoftSolitaireCollection";     Match = "MicrosoftSolitaireCollection";      License = "MicrosoftSolitaireCollection";      Dependencies = @("Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.MicrosoftStickyNotes";              Match = "MicrosoftStickyNotes";              License = "MicrosoftStickyNotes";              Dependencies = @("Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"; "Microsoft.Services.Store.Engagement"); }
						@{ Name ="Microsoft.MixedReality.Portal";               Match = "MixedReality.Portal";               License = "MixedReality.Portal";               Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.MSPaint";                           Match = "MSPaint";                           License = "MSPaint";                           Dependencies = @("Microsoft.UI.Xaml.2.0"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.Office.OneNote";                    Match = "Office.OneNote";                    License = "Office.OneNote";                    Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.People";                            Match = "People";                            License = "People";                            Dependencies = @("Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.ScreenSketch";                      Match = "ScreenSketch";                      License = "ScreenSketch";                      Dependencies = @("Microsoft.UI.Xaml.2.0"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.SkypeApp";                          Match = "SkypeApp";                          License = "SkypeApp";                          Dependencies = @("Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.StorePurchaseApp";                  Match = "StorePurchaseApp";                  License = "StorePurchaseApp";                  Dependencies = @("Microsoft.NET.Native.Framework.1.7"; "Microsoft.NET.Native.Runtime.1.7"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.Wallet";                            Match = "Wallet";                            License = "Wallet";                            Dependencies = @("Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WebMediaExtensions";                Match = "WebMediaExtensions";                License = "WebMediaExtensions";                Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.Windows.Photos";                    Match = "Windows.Photos";                    License = "Windows.Photos";                    Dependencies = @("Microsoft.UI.Xaml.2.0"; "Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WindowsAlarms";                     Match = "WindowsAlarms";                     License = "WindowsAlarms";                     Dependencies = @("Microsoft.UI.Xaml.2.3"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WindowsCalculator";                 Match = "WindowsCalculator";                 License = "WindowsCalculator";                 Dependencies = @("Microsoft.UI.Xaml.2.0"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WindowsCamera";                     Match = "WindowsCamera";                     License = "WindowsCamera";                     Dependencies = @("Microsoft.NET.Native.Framework.1.7"; "Microsoft.NET.Native.Runtime.1.7"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.windowscommunicationsapps";         Match = "windowscommunicationsapps";         License = "windowscommunicationsapps";         Dependencies = @("Microsoft.Advertising.Xaml"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WindowsFeedbackHub";                Match = "WindowsFeedbackHub";                License = "WindowsFeedbackHub";                Dependencies = @("Microsoft.UI.Xaml.2.0"; "Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WindowsMaps";                       Match = "WindowsMaps";                       License = "WindowsMaps";                       Dependencies = @("Microsoft.UI.Xaml.2.3"; "Microsoft.NET.Native.Framework.2.2"; "Microsoft.NET.Native.Runtime.2.2"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.WindowsSoundRecorder";              Match = "WindowsSoundRecorder";              License = "WindowsSoundRecorder";              Dependencies = @("Microsoft.UI.Xaml.2.3"; "Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.YourPhone";                         Match = "YourPhone";                         License = "YourPhone";                         Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.ZuneMusic";                         Match = "ZuneMusic";                         License = "ZuneMusic";                         Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name ="Microsoft.ZuneVideo";                         Match = "ZuneVideo";                         License = "ZuneVideo";                         Dependencies = @("Microsoft.VCLibs.140.00"); }
						@{ Name = "Microsoft.MinecraftEducationEdition";        Match = "MinecraftEducationEdition";         License = "MinecraftEducationEdition";         Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
						@{ Name = "Microsoft.Whiteboard";                       Match = "Whiteboard";                        License = "Whiteboard";                        Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
					)
				}
				Language = @{
					ISO = @(
						@{
							ISO = "https://software-download.microsoft.com/download/pr/19041.1.191206-1406.vb_release_CLIENTLANGPACKDVD_OEM_MULTI.iso";
							CRCSHA = @{
								SHA256 = "201269a05a09dba91d47923c733d43f38f38ebf33de2fd0750887d2763886743";
								SHA512 = ""
							}
						}
						@{
							ISO = "https://software-download.microsoft.com/download/pr/19041.1.191206-1406.vb_release_amd64fre_FOD-PACKAGES_OEM_PT1_amd64fre_MULTI.iso";
							CRCSHA = @{
								SHA256 = "0faaa11d86fbf66af059df4330a5ecf664323ce370ea898bc9beb4f03c048e95";
								SHA512 = ""
							}
						}
					)
					Rule = @(
						#region Boot
						@{
							Uid  = "Boot;Boot;Wim;"
							Rule = @(
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "WinPE-Setup_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "WINPE-SETUP-CLIENT_{Lang}.CAB";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
							)
						}
						#endregion
		
						#region Install
						@{
							Uid  = "Install;Install;Wim;"
							Rule = @(
								@{ Match = "Microsoft-Windows-LanguageFeatures-Fonts-{DiyLang}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = ""; }
								@{ Match = "Microsoft-Windows-Client-Language-Pack_{ARCHC}_{Lang}.cab";                                    Structure = "{ARCHC}\langpacks"; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Basic-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";        Structure = ""; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Handwriting-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";  Structure = ""; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-OCR-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";          Structure = ""; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-Speech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";       Structure = ""; }
								@{ Match = "Microsoft-Windows-LanguageFeatures-TextToSpeech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab"; Structure = ""; }
								@{ Match = "Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";      Structure = ""; }
								@{ Match = "Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = ""; }
								@{ Match = "Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                    Structure = ""; }
								@{ Match = "Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = ""; }
								@{ Match = "Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                    Structure = ""; }
								@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";              Structure = ""; }
								@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";             Structure = ""; }
								@{ Match = "Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";               Structure = ""; }
								@{ Match = "Microsoft-Windows-Printing-PMCPPC-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";            Structure = ""; }
								@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                   Structure = ""; }
								@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                  Structure = ""; }
								@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = ""; }
								@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                    Structure = ""; }
								@{ Match = "Microsoft-Windows-InternationalFeatures-{Specific}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = ""; }
							)
						}
						#endregion
		
						#region WinRE
						@{
							Uid  = "Install;WinRE;Wim;"
							Rule = @(
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
								@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-appxpackaging_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-storagewmi_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-wifi_{Lang}.cab";            Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-rejuv_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-opcservices_{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
								@{ Match = "winpe-hta_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
							)
						}
						#endregion
					)
				}
			}
			#endregion
		)
	}
)

<#
	Template

	@{
		GUID        = "Template"
		Author      = ""
		Copyright   = ""
		Name        = "Template"
		Description = ""
		Autopilot   = @{
			Prerequisite = @{
				x64 = @{
					ISO = @{
						Language  = @(
							""
						)
						InBoxApps = @(
							""
						)
					}
				}
			}
		}
		ISO         = @(
			""
		)
		InboxApps   = @{
			ISO = @(
				@{
					ISO = "";
					CRCSHA = @{
						SHA256 = "";
						SHA512 = ""
					}
				}
			)
			SN = @{
				Edition = @(
					"EnterpriseS"
					"EnterpriseSN"
					"IoTEnterpriseS"
				)
			}
			Edition = @(
				@{
					Name = @(
						"Core"
						"CoreN"
						"CoreSingleLanguage"
						"EnterpriseN"
						"EnterpriseGN"
						"EnterpriseSN"
						"ProfessionalN"
						"EducationN"
						"ProfessionalWorkstationN"
						"ProfessionalEducationN"
						"CloudN"
						"CloudEN"
						"CloudEditionLN"
						"StarterN"
					)
					Apps = @(
						"Microsoft.UI.Xaml.2.3"
					)
				}
			)
			Rule = @(
				@{ Name ="Microsoft.ZuneVideo"; Match = "ZuneVideo"; License = "ZuneVideo"; Dependencies = @("Microsoft.VCLibs.140.00"); }
			)
		}
		Language = @{
			ISO = @(
				ISO = "";
				CRCSHA = @{
					SHA256 = "";
					SHA512 = ""
				}
			)
			Rule = @(
				@{
					Uid  = "Boot;Boot;Wim;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
					)
				}
				@{
					Uid  = "Install;Install;Wim;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
					)
				}
				@{
					Uid  = "Install;WinRE;Wim;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
					)
				}
			)
		}
	}
#>
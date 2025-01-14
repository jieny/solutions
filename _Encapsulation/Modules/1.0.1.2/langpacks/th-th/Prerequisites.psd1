﻿ConvertFrom-StringData -StringData @'
	# th-TH
	# Thai (Thailand)

	Prerequisites                   = ข้อกำหนดเบื้องต้น
	Check_PSVersion                 = ตรวจสอบ PS เวอร์ชัน 5.1 ขึ้นไป
	Check_OSVersion                 = ตรวจสอบเวอร์ชัน Windows > 10.0.16299.0
	Check_Higher_elevated           = เช็คจะต้องยกระดับสิทธิ์ให้สูงขึ้น
	Check_execution_strategy        = ตรวจสอบกลยุทธ์การดำเนินการ

	Check_Pass                      = ผ่าน
	Check_Did_not_pass              = ล้มเหลว
	Check_Pass_Done                 = ยินดีด้วย ผ่านไปแล้ว
	How_solve                       = วิธีแก้ปัญหา
	UpdatePSVersion                 = โปรดติดตั้ง PowerShell เวอร์ชันล่าสุด
	UpdateOSVersion                 = 1. ไปที่เว็บไซต์อย่างเป็นทางการของ Microsoft เพื่อดาวน์โหลดระบบปฏิบัติการเวอร์ชันล่าสุด\n    2. ติดตั้งระบบปฏิบัติการเวอร์ชันล่าสุดแล้วลองอีกครั้ง
	HigherTermail                   = 1. เปิด Terminal หรือ PowerShell ISE ในฐานะผู้ดูแลระบบ, \n       ตั้งค่านโยบายการดำเนินการ PowerShell: บายพาส, บรรทัดคำสั่ง PS: \n\n       Set-ExecutionPolicy -ExecutionPolicy Bypass -Force\n\n    2. เมื่อแก้ไขแล้วให้รันคำสั่งอีกครั้ง.
	HigherTermailAdmin              = 1. เปิด Terminal หรือ PowerShell ISE ในฐานะผู้ดูแลระบบ. \n     2. เมื่อแก้ไขแล้วให้รันคำสั่งอีกครั้ง.
	LowAndCurrentError              = เวอร์ชันขั้นต่ำ: {0} เวอร์ชันปัจจุบัน: {1}
	Check_Eligible                  = มีสิทธิ์
	Check_Version_PSM_Error         = เกิดข้อผิดพลาดเกี่ยวกับเวอร์ชัน โปรดดูที่ {0}.psm1.Example อัปเกรด {0}.psm1 ใหม่แล้วลองอีกครั้ง

	Check_OSEnv                     = การตรวจสอบสภาพแวดล้อมของระบบ
	Check_Image_Bad                 = ตรวจสอบว่าภาพที่โหลดเสียหายหรือไม่
	Check_Need_Fix                  = สิ่งของแตกหักที่ต้องซ่อมแซม
	Image_Mount_Mode                = โหมดเมานต์
	Image_Mount_Status              = สถานะเมานท์
	Check_Compatibility             = การตรวจสอบความเข้ากันได้
	Check_Duplicate_rule            = ตรวจสอบรายการกฎที่ซ้ำกัน
	Duplicates                      = ทำซ้ำ
	ISO_File                        = ISO ไฟล์
	ISO_Langpack                    = ISO ชุดภาษา
'@
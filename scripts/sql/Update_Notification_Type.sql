
-- FAPA 1436

update coeus.notification_type 
set message  = 'The Award Notice for Award {AWARD_NUMBER} is available for printing: <a title="" target="_self" href="{DOCUMENT_PREFIX}/awardActions.do?methodToCall=printNoticeFromNotification&amp;awardNoticeId={AWARD_NOTICE_ID}"><img src="{DOCUMENT_PREFIX}/static/images/tinybutton-print.gif" alt="Print Award Notice for Award {AWARD_NUMBER}"></a>
<p> To access the award, <a title="" target="_self" href="{DOCUMENT_PREFIX}/kc-common/awards/{AWARD_NUMBER}">click here</a></p>', prompt_user = 'Y' where action_code = 556;



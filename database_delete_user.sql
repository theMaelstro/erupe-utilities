-- File Version:	1.0.0
-- Server Version:	9.0.1.1
-- Credit:	MAEL (theMaelstro)

-- HOW TO USE
-- REPLACE ? WITH USER_ID
-- COPY QUERY AND PASTE INTO PSQL TOOL
-- HIT ENTER
-- IF ONLY OUTPUT IS "erupe=#" THE QUERY WORKED
-- OTHERWISE IT WILL DISPLAY ERRORS

-- SCREENSHOT OR COPY ERROR MESSAGE AND CONTACT ME IF HELP IS NEEDED

-- QUERY
DO $$ 
DECLARE
	usertodelete    INTEGER := ?;	
BEGIN 
	-- User Keys
	DELETE FROM public.account_ban WHERE user_id = usertodelete;
	DELETE FROM public.account_history WHERE user_id = usertodelete;
	DELETE FROM public.history WHERE user_id = usertodelete OR report_id IN (SELECT report_id FROM public.account_history WHERE user_id = usertodelete);
	DELETE FROM public.sign_sessions WHERE user_id = usertodelete;	
	
	-- Guild Keys
	DELETE FROM public.festa_registrations WHERE guild_id IN (SELECT id FROM public.guilds WHERE leader_id = usertodelete);
	DELETE FROM public.guild_adventures WHERE guild_id IN (SELECT id FROM public.guilds WHERE leader_id = usertodelete);
	DELETE FROM public.guild_hunts WHERE guild_id IN (SELECT id FROM public.guilds WHERE leader_id = usertodelete);
	DELETE FROM public.guild_meals WHERE guild_id IN (SELECT id FROM public.guilds WHERE leader_id = usertodelete);
	DELETE FROM public.guild_posts WHERE guild_id IN (SELECT id FROM public.guilds WHERE leader_id = usertodelete);
	
	-- Character Keys
	DELETE FROM public.cafe_accepted WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.distribution WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.distributions_accepted WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.festa_prizes_accepted WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.guild_applications WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete) OR character_id IN (SELECT id FROM public.guilds WHERE leader_id = usertodelete);
	DELETE FROM public.guild_characters WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete) OR character_id IN (SELECT id FROM public.guilds WHERE leader_id = usertodelete);
	DELETE FROM public.login_boost_state WHERE char_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.lucky_box_state WHERE char_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.mail WHERE sender_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete) OR recipient_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.rengoku_score WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.shop_item_state WHERE char_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.stamps WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.stepup_state WHERE char_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.titles WHERE char_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	DELETE FROM public.warehouse WHERE character_id IN (SELECT id FROM public.characters WHERE user_id = usertodelete);
	
	-- Contraints
	DELETE FROM public.guilds WHERE leader_id = usertodelete;
	DELETE FROM public.characters WHERE user_id = usertodelete;
	DELETE FROM public.users WHERE id = usertodelete;
END $$;
--
CREATE OR REPLACE FUNCTION handleRent3(part_request_id UUID, acceptor_id INT) 
RETURNS TEXT AS $$
DECLARE
    request_part_id INT;
    request_rent_count INT;
    request_user_id INT;
    available_count INT;
    physical_part_ids TEXT[];
BEGIN

	-- BEGIN
	SELECT "partId_id", "rentCount", "userId_id"
	INTO request_part_id, request_rent_count, request_user_id
	FROM "Data_partrequest"
	WHERE "requestId" = part_request_id;

	SELECT COUNT(*)
	INTO available_count
	FROM "Data_physicalpart"
	WHERE "partId_id" = request_part_id AND type = 1; -- 1 = Available

	IF available_count < request_rent_count THEN
		-- INSERT INTO "Data_deniedrequest" (
		--     "userId_id", 
		--     "partId_id", 
		--     "requestSubmissionDate", 
		--     "denierInspectorId_id", 
		--     "denialReason"
		-- ) VALUES (
		--     request_user_id, 
		--     request_part_id, 
		--     NOW(), 
		--     acceptor_id, 
		--     'Insufficient available physical parts'
		-- );
		Update "Data_partrequest"
		SET "isAccepted" = FALSE, "examineDate" = NOW()
		Where "requestId" = part_request_id;

		INSERT INTO "Data_requestdetail" 
				(result, description, inspector_id, "requestId_id")
				VALUES (
				FALSE,
				'Denied due to insufficient available physical parts',
				acceptor_id,
				part_request_id);
	
	        -- DELETE FROM "Data_partrequest" WHERE "requestId" = part_request_id;
	
	        RETURN 'Denied due to insufficient available physical parts';
	    END IF;
	
	    SELECT ARRAY(
	        SELECT "physicalId"
	        FROM "Data_physicalpart"
	        WHERE "partId_id" = request_part_id AND type = 1 -- Available
	        LIMIT request_rent_count
	    ) INTO physical_part_ids;
	
	    UPDATE "Data_physicalpart"
	    SET type = 2 -- Rented
	    WHERE "physicalId" = ANY(physical_part_ids);
	
	    INSERT INTO "Data_rentedpart" (
	        "userId_id", 
	        "physicalPartId_id", 
	        "rentDate"
			-- "acceptorInspectorId_id"
	    ) SELECT 
	        request_user_id, 
	        unnest(physical_part_ids), 
	        NOW();


	        -- acceptor_id;
	
		Update "Data_partrequest"
		SET "isAccepted" = TRUE  , "examineDate" = NOW()
		Where "requestId" = part_request_id;
	
		INSERT INTO "Data_requestdetail" 
		(result, description, inspector_id, "requestId_id"  )  
		VALUES (
		TRUE ,
		'No caption',
		acceptor_id,
		part_request_id);
		
		
	    -- DELETE FROM "Data_partrequest" WHERE "requestId" = part_request_id;
	-- COMMIT;
RETURN 'Request processed successfully';

	-- EXCEPTION
 --        WHEN OTHERS THEN
 --            -- Rollback the transaction in case of any error
 --            ROLLBACK;
 --            -- Optionally, log the error or re-raise it
 --            RAISE NOTICE 'Error occurred: %', SQLERRM;
 --            RETURN 'Error processing request: ' || SQLERRM;
	-- END;
END;
$$ LANGUAGE plpgsql;
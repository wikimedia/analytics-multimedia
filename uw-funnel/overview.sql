SET
    @survivors = NULL -- holds number of users reaching the next step
;

SELECT
    step,
    @survivors / survivors AS relative,
    @survivors := survivors AS absolute
FROM (
    SELECT
        event_step AS step,
        COUNT(*) AS survivors
    FROM
        UploadWizardStep_8851805
    WHERE
        timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
    GROUP BY
        event_step
    ORDER BY
        -- we need to calculate (users reaching next step / users reaching current step)
        -- but there is no way to know abou the next row, so we reverse the ordering
        -- here, then reverse it again in the outer select
        survivors ASC
) uploadwizard_funnel_data
ORDER BY
    absolute DESC
;
